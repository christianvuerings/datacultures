# RAILS_ENV Setup

In all of the commands below, it is assumed that a `RAILS_ENV` is set to the Rails environment (typically, 'production' for production). If you have already opened other shells on this host, you will need to run source on them as well (once the RAILS_ENV has been set in the home directory, new non-login shells will have this variable set. ssh shells and iTerm shells are usually non-login).

```shell
    echo "export RAILS_ENV=\"production\"" >> ~/.bashrc
    source ~/.bashrc
```

If you are in a login shell (and will work with one in the future), use instead:

```shell
    echo "export RAILS_ENV=\"production\"" >> ~/.profile
    source ~/.profile
```

It wouldn't hurt to do both, only one is used by a given shell.
