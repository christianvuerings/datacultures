# Data Cultures

The Data Cultures LTI provider application running in Canvas

[![Dependency Status](https://gemnasium.com/ets-berkeley-edu/datacultures.svg)](https://gemnasium.com/ets-berkeley-edu/datacultures) [![Code Climate](https://codeclimate.com/github/ets-berkeley-edu/datacultures/badges/gpa.svg)](https://codeclimate.com/github/ets-berkeley-edu/datacultures)
* Master Build: [![Build Status](https://api.travis-ci.org/ets-berkeley-edu/datacultures.svg?branch=master)](https://travis-ci.org/ets-berkeley-edu/datacultures)

## JavaScript

Rails requires a JavaScript runtime. If one is not installed and in the `PATH`, I suggest node.js runtime. Select **one** option below:
  * Install [with a package manger](https://github.com/joyent/node/wiki/installing-node.js-via-package-manager)
  * [from sources](https://github.com/joyent/node/wiki/Installation). Note that it will require Python 2.6 or 2.7 if installed from source
  * The node site has some [binary downloads](http://nodejs.org/download/)

The directory with the node binary must then be put into the system PATH. A "which node" command must be able to find it.

## [Initial Application Setup](docs/application_setup.md)

Detailed setup instructions, grouped by logical page. This includes getting the code, configuration, etc.

## [Application Deploy](docs/application_deploy.md)

Instructions on manual application deployment (after it has been set up once). There are four scenarios: ruby code-only deploy, ruby code deploy with migration, ruby code deploy with javascript, and ruby code, javascript, and migrations. But it is done as one step, plus two optional steps.

## Testing

* [Configure Mocking Options for RSpec](docs/mock_options_configure.md) Mocking is enabled by default, which should be fine for most circumstances (in which case this section is optional).

## [Developer Setup](docs/developer_setup_optional.md)

(Optional) A slate of tools is included. Zeus and Guard can help accelerate development.
