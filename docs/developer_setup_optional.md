# Developer Setup (optional)

The following are all done from a Terminal (or iTerm2) window:

```shell
sudo gem install zeus
```

In your development environment, in one shell, start [zeus](https://github.com/burke/zeus):

```shell
zeus start
```

In another tab or window, start guard:

```shell
guard
```

Now, from other windows (or an edit tool such as RubyMine), change either a spec or the code it is covering, and it will be run in the guard window.

If you have changes to MOCK, to the configuration file (../config/.env_conf.yml) or any other operating system environment, it will be necessary to restart zeus if zeus is in use. It is also on occasion necessary to restart zeus if e.g., Rails initialization code is changed.
