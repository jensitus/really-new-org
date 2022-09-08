if Rails.env.production?
  CarrierWave.configure do |config|
    # config.root = Rails.root.join('tmp') # adding these...
    # config.cache_dir = 'carrierwave' # ...two lines
    config.fog_credentials = {
      # Configuration for Amazon AWS
      :provider => 'AWS',
      :aws_access_key_id => ENV["S3_DO_ACCESS_KEY"], # Rails.application.secrets.s3_access_key,      # ,ENV['S3_ACCESS_KEY']
      :aws_secret_access_key => ENV["S3_DO_SECRECT_KEY"], # Rails.application.secrets.s3_secret_key   # ENV['S3_SECRECT_KEY']
      :region => 'fra1',
      :host => 'fra1.digitaloceanspaces.com',
      :endpoint => 'https://fra1.digitaloceanspaces.com'
    }
    config.fog_directory = ENV["S3_DO__BUCKET"], # Rails.application.secrets.s3_bucket              # ENV['S3_BUCKET']
    config.fog_attributes = { cache_control: "public, max-age=#{365.days.to_i}" } # optional, defaults to {}
  end
end
