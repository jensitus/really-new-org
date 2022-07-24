# The "upset" gem-in-growth

This directory contains the `upset` script (in `upset/bin/upset`).

The upset scripts is able to manage a deployed application. It is not strictly bound to rails; instead it assumes the following:

- it can work against and potentially take over an entire host;
- it fetches and updates source code versions from github via git;
- the source code itself might contain scripts to set up a deplyoed instance.

## Working example

[![asciicast](https://asciinema.org/a/nHDa5fZ6fC5DkWW5xERjFrAyZ.svg)](https://asciinema.org/a/nHDa5fZ6fC5DkWW5xERjFrAyZ)

### Initial setup

    # get a host
    (cd ~/projects/uc-setup && bin/uc host:setup worldwildweb.16b.org)

The bootstrap script provides some general tooling and initializes global settings.
    
    # run bootstrap script
    ./upset/bin/upset bootstrap worldwildweb.16b.org

At minimum you must provide the `RAILS_MASTER_KEY` configuration.

    # basic configuration
    ./upset/bin/upset configure worldwildweb.16b.org RAILS_MASTER_KEY=thesecret    

Deploy the current repo to the host. This also installs all required dependencies (specific database version, caddy web server, postgresql database, etc.), installs required gems, and migrates the database. Therefore the first run might take a bit longer.

    # deploy current repo to host
    ./upset/bin/upset deploy worldwildweb.16b.org

Now this works:

    # fetch output from web server
    curl https://worldwildweb.16b.org

### Deploying a new version

You can deploy a new version using 

    ./upset/bin/upset deploy worldwildweb.16b.org

This loads the latest version from github. (i.e. make sure you push the source code to github!)

## Online help

upset comes with some online help. Run

    ./upset/bin/upset help

to learn more


