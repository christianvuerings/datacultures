# Deploy the Application

## Code deployment

* shell (ssh) into your server, change to the project directory:

```shell
    ssh deploy-host.net
    cd ~/datacultures
```

There is a script for the simplest possible deploy. For it, a shell variable $DOCROOT must be set to where static assets are to be served from.  Then run the script:

```shell
    bin/deploy.sh
```

(this script has not yet been merged into master, it is at https://github.com/coyote/datacultures/blob/deploy_script/bin/deploy.sh )
Or you can do the steps one by one:

* Make sure there are no unstaged changes, or staged and not committed changes. Below 'origin' the git remote where the code to deploy is located:

```shell
$ git status
On branch master
nothing to commit, working directory clean
```

3. Pull the latest code:

```shell
    git pull origin master
```

Git will print a summary of changes made since the last pull. If it responds with:

```shell
    git pull origin master
    From github.com:coyote/datacultures
     * branch            master -> FETCH_HEAD
    Already up-to-date.
```

Then you are already up to date. Here, "github.com:coyote/datacultures" is the remote reference.

## Bundle rubygems

If the Gemfile or Gemfile.lock has changed, it will be necessary to bundle (this cannot hurt, and won't take long at all if nothing has changed):

```shell
    bundle
```

## Migrate the DataBase

If there are migrations (when you did the git pull, if there are any files in the db/migration directory, there are migrations), then you must migrate the database. You will see something like this:

```shell
    rake db:migrate
    == 20141015203016 CreateMediaUrls: migrating ==================================
    -- create_table(:media_urls)
       -> 0.0387s
    == 20141015203016 CreateMediaUrls: migrated (0.0388s) =========================
```

It won't hurt to run this if there are no migrations, it will produce no output.

## Compile (and copy if needed) any new assets

If there are new assets, it is necessary to compile them. If your server has a different $DOCROOT and you are not serving static assets from the application server (which is the default and usual setup for production), you must copy the resulting assets into the $DOCROOT (as set in your web server's config [e.g., httpd.conf]):

```shell
    rake assets:clobber
    rake assets:precompile
    cp -R public/assets/*  $DOCROOT/assets
```
