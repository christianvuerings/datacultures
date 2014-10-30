# Datacultures Configuration

Copy the sample configuration file to the configuration directory. This is used as a template for the final configuration.

```shell
mkdir -p config
cp datacultures/config/.env_conf.yml.example config/.env_conf.yml
```

The LTI standard specifies that an embedded LTI provider share an application key and application secret for authentication. They are configured from the Canvas UI.

The database and Canvas information must be updated. Do this for each environment you wish to configure (production, qa, staging, development, etc):

From the sample file:
```yaml
production:
  assets:
    served_by_app_server:  false   # set to false where Apache is available
  databases:
    database: 'datacultures_production'
    host: 'localhost'
    port:  5432
  api:
    server:  'http://localhost:3100/'
    course: '1'
    api_key:  'FOOBARBAZ'
```

Edit the configuration file (../config/.env_conf.yml relative the project root, directory created and file copied as above) Configure the 'databases' section with appropriate values:

```yaml
  databases:
    database: 'lti_app_live'
    host: 'https://some.database.host'
    port:  9000
```

and also configure the last section. This section is for the Canvas instance in which the app is embedded. If the [instructor's API key](api_key_generation.md) is 'uq0b5QOsjTfpAjYjXUFSUur7lkX2JkgKJlDNKc+FA3Q3gwmQYTo1MOIpAlt112pfjBeuG0N7bvqP9YGrXWPTmnQ', it might look like this:

```yaml
  api:
    server: 'https://datacultures-canvas.instructure.com/'
    course: '30765'
    api_key:  'uq0b5QOsjTfpAjYjXUFSUur7lkX2JkgKJlDNKc+FA3Q3gwmQYTo1MOIpAlt112pfjBeuG0N7bvqP9YGrXWPTmnQ'
```
