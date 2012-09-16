MNML
====

A minimal rails, backbone, handlebars + bootstrap single-page app setup.

Introduction
------------

Use this project as a foundation to kick-start your own app, copy bits & pieces, fork it. Rather than installing everything directly onto your workstation, I highly recommend you follow the instructions below to quickly build a *"lightweight, reproducible, and portable development environment"* with [Vagrant](http://vagrantup.com/).

Getting started
---------------

To get you up and running, you'll need:

  * [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
  * [Vagrant](http://downloads.vagrantup.com/)

Once you've installed these, **spin up your dev box** via:

    host $ https://github.com/pmeinhardt/mnml.git
    host $ cd mnml
    host $ vagrant up

*This takes about 6-10 minutes to complete (download of the base box not included, depends on your network).* Afterwards, you'll have your execution environment ready, with all the dependencies installed ([Ruby](http://www.ruby-lang.org/en/) via [rbenv](https://github.com/sstephenson/rbenv) and [ruby-build](https://github.com/sstephenson/ruby-build), [PostgreSQL](http://www.postgresql.org/), [NodeJS](http://nodejs.org/), optionally [Redis](http://redis.io/), [Memcached](http://memcached.org/), [ImageMagick](http://www.imagemagick.org/)…), everything configured appropriately and all necessary services already running in the virtual machine.

In case you come across any *errors* or *skipped steps* in the console output, another call to `vagrant provision` might already resolve these issues.

**Configure database access**: Copy the default `database.yml`. In case you change it, you may have to update your postgres config accordingly.

    host $ cp config/database.yml.default config/database.yml

Now it's time to **start the Rails application**:

    host $ vagrant ssh            # ssh into the virtual machine
    guest $ cd /vagrant           # cd into the shared project folder
    guest $ bundle install        # install gems
    guest $ rails s               # start the server

The rails server port from the virtual machine will be forwarded to port 3000 on your host machine. This way you can simply **open [http://localhost:3000](http://localhost:3000) in your local browser** to examine what you're working on – just like you're used to.

Useful commands
---------------

If you need a console on the virtual machine, run:

    vagrant ssh

If you want to stop your dev box, call:

    vagrant suspend

For bringing it back up, use:

    vagrant resume

If you broke your virtual machine or the configuration has been updated, you may need to rebuild it:

    vagrant destroy  # confirm
    vagrant up

For smaller changes in the machine's dependencies or configuration, running `vagrant provision` will suffice.

For changes to the Vagrantfile, run `vagrant reload`.

To get an overview of all Vagrant commands, run `vagrant -h`.

Docs
----

All right! You're good to go then. For some more details on working with Vagrant, let me point you to these resources:

  * [Vagrant Documentation](http://vagrantup.com/v1/docs/)
  * [Vagrantfile Docs](http://vagrantup.com/v1/docs/vagrantfile.html)

For provisioning (server configuration management) we're using [Puppet](http://docs.puppetlabs.com/puppet/). Some good places to start with Puppet could be:

  * [Puppet Language Guide](http://docs.puppetlabs.com/guides/language_guide.html)
  * [Puppet Type Reference](http://docs.puppetlabs.com/references/stable/type.html)
