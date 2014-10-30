# Configure Mocking Options

To always mock, set the OS environment variable MOCK to 'always'. To never mock, set MOCK to 'never'. The default is to mock. So if you wish to actually access the Canvas server in your tests set from the directory where the test will be run:

```shell
export MOCK=always
```

Optionally, you may set this value in your ~/.profile or ~/.bashrc

An alternative way to set the mocking value is to configure it in the ../config/.env_conf.yml file (the same file as is referenced above). Set the following values:

```yaml
test:
  real_requests: false
```

Setting this value to false means mock, setting it to true means make real request in the specs. The value is set to false in example yaml file.
