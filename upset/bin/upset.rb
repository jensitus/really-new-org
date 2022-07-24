#!/usr/bin/env ruby
require "bundler/inline"

gemfile do
  source "https://rubygems.org"

  gem "simple-cli", "~> 0.4.2"
  # gem "simple-cli", path: "~/projects/ruby/simple-cli"
end

# We assume that this script is called via the upset shell wrapper. The
# following line adjusts $0, so that the Simple::CLI help is printing the
# shell wrapper's name, not the name ending in .rb.
$0.gsub! /\.rb$/, ""

module Upset
  module H
    extend self

    def relative_path(path)
      Pathname.new(path).relative_path_from(Dir.getwd).to_s
    end
  end
  
  UPSET_ROOT_DIR=File.expand_path "#{__dir__}/.."
  
  include ::Simple::CLI

  # List all sceavailable narios
  def list
    logger.info "scenarios are loaded from #{scenario_dir}"
    scenarios.each do |scenario|
      puts "%-29s - %s" % [ scenario.name, scenario.info ]
    end
  end

  # Print information about a scenario
  def info(scenario = nil)
    scenarios = if scenario
      expect! scenario => self.scenarios.map(&:name)
      [ Scenario.load(scenario) ]
    else
      self.scenarios
    end

    scenarios.each do |scenario| 
      _print_info(scenario)
      puts "\n"
    end
  end

  def _print_info(scenario)
    puts <<~MSG
    == #{scenario.name}: #{scenario.info}

    MSG

    fstr = "%-29s - %s"
    fstr = "%-29s - %s; see %s" if logger.level == ::Logger::DEBUG
    scenario.scripts.each do |script|
      puts fstr % [ script.name, script.info, H.relative_path(script.path) ]
    end
  end

  # Run bootstrap script
  #
  # This sets up basic configuration on the remote host, and runs an initial checkout of the repo.
  #
  # Example:
  #
  #     upset bootstrap really-new-org.16b.org radiospiel/really-new-org
  def bootstrap(host)
    sys! "nslookup #{host} 2>&1 > /dev/null"

    giturl = `git remote -v | grep fetch | awk '{print $2}'`.chomp
    
    sys! "cat #{__dir__}/bootstrap.sh | ssh -oForwardAgent=yes root@#{host} 'cat > ./bootstrap.sh; chmod +x ./bootstrap.sh ; HOST=#{host} GITURL=#{giturl} ./bootstrap.sh'"
  end

  # set configuration
  #
  # This sets a basic configuration on the remote host, in the deploy user's home directory
  #
  # Example:
  #
  #     upset configure really-new-org.16b.org RAILS_ENV=production
  def configure(host, env, *envs)
    sys! "nslookup #{host} 2>&1 > /dev/null"

    ([ env ] + envs).each do |entry|
      expect! entry => /^[A-Z0-9_]+=\S+$/
      ssh! "root@#{host}", "echo export #{entry} >> /etc/upset.inc"
    end
  end
  
  # Run the deploy scenario on a specific host
  #
  # The list of available scenarions is available via "upset list"
  def deploy(host)
    perform host, "deploy"
    perform host, "deploy-post"
  end
  
  def perform(host, scenario)
    expect! scenario => scenarios
    ssh! "deploy@#{host}", "cd src && ./upset/bin/upset run #{scenario}"
  end
  
  # perform a specific scenario
  #
  # The list of available scenarions is available via "upset list"
  def run(scenario)
    scenario = Scenario.new(scenario_dir, scenario)
    scenario.run
  end
  
  private

  def ssh!(*args)
    sys! "ssh", "-oForwardAgent=yes", "-t", *args
  end

  class Scenario
    attr_reader :basedir, :name

    def initialize(basedir, name)
      @basedir, @name = basedir, name
    end

    def path; "#{basedir}/#{name}"; end
    
    def description
      File.read("#{path}/README.md")
    rescue Errno::ENOENT
      "# '#{name}' scenario"
    end

    def info
      description.split("\n").each do |line|
        return $1 if line =~ /^#+ \s*(.*)/
      end
      nil
    end

    def scripts
      @scripts ||= Dir.new(path).children.
        map { |name| Script.load(self, name) }.
        compact.
        sort_by { |sc| sc.name.to_i }
    end

    def run
      scripts.each(&:run)
    end

    class Script
      include Simple::CLI::Helpers
      
      FILENAME_REGEXP = /(.*)\.(user|root)\.sh$/

      def self.load(scenario, filename)
        return nil unless filename =~ FILENAME_REGEXP

        Script.new($1, scenario, filename)
      end

      attr_reader :name, :scenario, :filename
      
      def initialize(name, scenario, filename)
        @name, @scenario, @filename = name, scenario, filename
      end

      def run
        relative_path = Upset::H.relative_path(path)

        case relative_path
        when /\.user\.sh$/
          sys! relative_path
        when /\.root\.sh$/
          sys! "sudo --preserve-env #{relative_path}"
        end
      end

      def path; "#{scenario.path}/#{filename}"; end

      def info
        File.open(path).readlines.each_with_index do |line, idx|
          next if idx == 0 && line =~ /^#\!\//

          next unless line =~ /^#\s+(.*)/
          return $1.gsub(/\-\-+\s+/, "")
        end

        "info for #{name}"
      end
    end
  end

  def scenarios
    @scenarios ||= Dir.new(scenario_dir).
      children.
      select { |name| File.directory?("#{scenario_dir}/#{name}") }.
      sort.
      map { |name| Scenario.new(scenario_dir, name) }.
      compact.
      map(&:name)
  end

  def scenario_dir
    "#{UPSET_ROOT_DIR}/scenarios"
  end
end

Simple::CLI.run! ::Upset
