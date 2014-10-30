# Application Setup

Instructions are for any *nix type system. Commands are to be run from a terminal window (e.g., a bash shell in Terminal or iTerm), or in a similar shell in Linux or FreeBSD. Unless otherwise specified, commands are to be run from the project directory, once it has been cloned. The steps should be taken in order.

Production installation steps for Apache are listed with "_For Apache installs only._"  These are not relevant in non-production environments (e.g., development and test), and must be modified for the target web server if passenger and Apache are not used.

It is highly suggested that you [Setup the RAILS_ENV environment variable](rails_env_setup.md) or anytime you are not working in "development" you will need to prefix any rails/rake/thor commands with e.g., "RAILS_ENV=production "

Now follow these steps in order:

* [System Setup](system_setup.md) This includes system libraries, rvm, ruby, and an application gemset.

* [Obtaining the Code](obtain_code.md)

* [Internationalization](internationalization.md) Configure the display names for the participation category names and the application's User-Agent name. Optional for English-language installations.

* Run the Thor task to generate new application secrets. It should be done at least once for a new install, and at any time later desired. If it is done later, it will require a server reboot to pick up the new values.
```shell
    thor keys:app_new_secret
```

* [Configuring the Canvas instance in which Data Cultures is embeded](canvas_configuration.md) Canvas must know about the Data Cultures LTI provider application.

* [Generate Canvas API keys](api_key_generation.md)

* [Configuring Data Cultures](datacultures_configuration.md)

* Bundling. The Ruby gems must be made available to the application:

```shell
    bundle install
```

* _For Apache installs only._ Compile passenger module This step must be taken once on first install, and any time the passenger gem version changes.

```shell
    passenger-install-apache2-module
```

* [Configure the Engagement Index Scoring Values](engagement_index_configuration.md) This step is optional, if the existing values are not desired. Random values are generated for the scoring items.

* Assets (e.g., JavaScripts, CSS files, images) should be precompiled to run the app:

```shell
    rake assets:precompile
```
* _For Apache installs only._ If you configuration requires, copy the assets into the $DOCROOT (where $DOCROOT is the base directory for the application for Apache to server static assets)

```shell
    cp -R public/assets/ $DOCROOT/
```
* _For apache installs only._  Start or restart Apache. For example, one of the below:

```shell
   apachectl -k restart

   apachectl -k start
```
