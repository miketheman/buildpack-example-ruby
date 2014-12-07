buildpack-example-ruby
======================
This is an example application for using the
[Heroku Buildpack for Datadog](https://github.com/miketheman/heroku-buildpack-datadog).

1. Deploy regular Ruby app

    The initial sample app. ([code](https://github.com/miketheman/buildpack-example-ruby/commit/692cc3da40541812e854ceb7f99803bee5363bb1))

    ```console
    2014-12-07T13:52:03.676664+00:00 heroku[api]: Release v2 created by miketheman@gmail.com
    2014-12-07T13:52:24.780943+00:00 heroku[api]: Set LANG, RACK_ENV config vars by miketheman@gmail.com
    2014-12-07T13:52:24.781106+00:00 heroku[api]: Release v3 created by miketheman@gmail.com
    2014-12-07T13:52:25.191250+00:00 heroku[api]: Scale to web=1 by miketheman@gmail.com
    2014-12-07T13:52:25.285141+00:00 heroku[api]: Deploy 692cc3d by miketheman@gmail.com
    2014-12-07T13:52:25.285271+00:00 heroku[api]: Release v4 created by miketheman@gmail.com
    2014-12-07T13:52:28.637852+00:00 heroku[web.1]: Starting process with command `rackup -s puma -p 52689`
    2014-12-07T13:52:29.572193+00:00 app[web.1]: Puma 2.10.2 starting...
    2014-12-07T13:52:29.572217+00:00 app[web.1]: * Environment: production
    2014-12-07T13:52:29.572219+00:00 app[web.1]: * Listening on tcp://0.0.0.0:52689
    2014-12-07T13:52:29.572212+00:00 app[web.1]: * Min threads: 0, max threads: 16
    2014-12-07T13:52:29.769074+00:00 heroku[web.1]: State changed from starting to up
    2014-12-07T14:05:10.000987+00:00 heroku[router]: at=info method=GET path="/" host=blooming-peak-9226.herokuapp.com request_id=6eeea41c-0ad2-4799-9964-b3df4ced5eee fwd="72.225.163.105" dyno=web.1 connect=1ms service=19ms status=200 bytes=255
    2014-12-07T14:05:10.504018+00:00 heroku[router]: at=info method=GET path="/favicon.ico" host=blooming-peak-9226.herokuapp.com request_id=613946cf-2b87-4d08-82d1-6b78ac326b4f fwd="72.225.163.105" dyno=web.1 connect=1ms service=3ms status=404 bytes=234
    ```

2. Add Ruby buildpack to the project along with Multi-buildpack

    Set the environment variable:

        heroku config:add BUILDPACK_URL=https://github.com/ddollar/heroku-buildpack-multi.git

    ```console
    2014-12-07T15:37:46.493015+00:00 heroku[api]: Release v5 created by miketheman@gmail.com
    2014-12-07T15:37:46.493015+00:00 heroku[api]: Set BUILDPACK_URL config vars by miketheman@gmail.com
    ```

    Then [add the default Ruby buildpack](https://github.com/miketheman/buildpack-example-ruby/commit/aa392ca1089f217646c19339c8d07a48a55d9180).

    ```console
    $ git push heroku master
    Counting objects: 3, done.
    Delta compression using up to 4 threads.
    Compressing objects: 100% (2/2), done.
    Writing objects: 100% (3/3), 325 bytes | 0 bytes/s, done.
    Total 3 (delta 1), reused 0 (delta 0)
    remote: Compressing source files... done.
    remote: Building source:
    remote:
    remote: -----> Fetching custom git buildpack... done
    remote: -----> Multipack app detected
    remote: =====> Downloading Buildpack: https://github.com/heroku/heroku-buildpack-ruby
    remote: =====> Detected Framework: Ruby
    remote: -----> Compiling Ruby/Rack
    remote: -----> Using Ruby version: ruby-2.1.5
    remote: -----> Installing dependencies using 1.6.3
    remote:        Running: bundle install --without development:test --path vendor/bundle --binstubs vendor/bundle/bin -j4 --deployment
    remote:        Using rack 1.5.2
    remote:        Using tilt 1.4.1
    remote:        Using bundler 1.6.3
    remote:        Using puma 2.10.2
    remote:        Using rack-protection 1.5.3
    remote:        Using sinatra 1.4.5
    remote:        Your bundle is complete!
    remote:        Gems in the groups development and test were not installed.
    remote:        It was installed into ./vendor/bundle
    remote:        Bundle completed (0.80s)
    remote:        Cleaning up the bundler cache.
    remote:
    remote: Using release configuration from last framework (Ruby).
    remote: -----> Discovering process types
    remote:        Procfile declares types     -> web
    remote:        Default types for Multipack -> console, rake
    remote:
    remote: -----> Compressing... done, 17.3MB
    remote: -----> Launching... done, v6
    remote:        https://blooming-peak-9226.herokuapp.com/ deployed to Heroku
    remote:
    remote: Verifying deploy... done.
    To https://git.heroku.com/blooming-peak-9226.git
    692cc3d..aa392ca  master -> master
    ```

3. Add [Datadog buildpack](https://github.com/miketheman/heroku-buildpack-datadog)

    First, set some env vars:

        heroku config:set HEROKU_APP_NAME=$(heroku apps:info|grep ===|cut -d' ' -f2)
        heroku config:add DATADOG_API_KEY=<your API key>

    ```console
    ...
    2014-12-07T15:52:13.567394+00:00 heroku[api]: Set HEROKU_APP_NAME config vars by miketheman@gmail.com
    2014-12-07T15:52:13.567435+00:00 heroku[api]: Release v7 created by miketheman@gmail.com
    2014-12-07T15:52:31.870132+00:00 heroku[api]: Set DATADOG_API_KEY config vars by miketheman@gmail.com
    2014-12-07T15:52:31.870132+00:00 heroku[api]: Release v8 created by miketheman@gmail.com
    2014-12-07T15:52:32.265512+00:00 heroku[web.1]: State changed from up to starting
    ...
    ````

    Then push [this commit](https://github.com/miketheman/buildpack-example-ruby/commit/518894843eba6459bd0e32574ed96dd865938ccc):

    ```console
    $ git push heroku master
    Counting objects: 3, done.
    Delta compression using up to 4 threads.
    Compressing objects: 100% (3/3), done.
    Writing objects: 100% (3/3), 359 bytes | 0 bytes/s, done.
    Total 3 (delta 1), reused 0 (delta 0)
    remote: Compressing source files... done.
    remote: Building source:
    remote:
    remote: -----> Fetching custom git buildpack... done
    remote: -----> Multipack app detected
    remote: =====> Downloading Buildpack: https://github.com/miketheman/heroku-buildpack-datadog.git
    remote: =====> Detected Framework: Heroku Datadog Buildpack
    remote: -----> Updating apt caches
    remote:        Ign http://apt.datadoghq.com stable InRelease
    remote:        Get:1 http://apt.datadoghq.com stable Release.gpg [473 B]
    remote:        Get:2 http://apt.datadoghq.com stable Release [1,796 B]
    remote:        Ign http://apt.datadoghq.com stable Release
    remote:        Get:3 http://apt.datadoghq.com stable/main amd64 Packages [4,969 B]
    remote:        Ign http://apt.datadoghq.com stable/main Translation-en_US
    remote:        Ign http://apt.datadoghq.com stable/main Translation-en
    remote:        Fetched 7,238 B in 0s (25.9 kB/s)
    remote:        Reading package lists...
    remote: W: GPG error: http://apt.datadoghq.com stable Release: The following signatures couldn't be verified because the public key is not available: NO_PUBKEY 226AE980C7A7DA52
    remote: -----> Fetching datadog-agent
    remote:        Reading package lists...
    remote:        Building dependency tree...
    remote:        The following NEW packages will be installed:
    remote:          datadog-agent
    remote:        0 upgraded, 1 newly installed, 0 to remove and 0 not upgraded.
    remote:        Need to get 49.6 MB of archives.
    remote:        After this operation, 164 MB of additional disk space will be used.
    remote:        WARNING: The following packages cannot be authenticated!
    remote:          datadog-agent
    remote:        Get:1 http://apt.datadoghq.com/ stable/main datadog-agent amd64 1:5.1.0-539 [49.6 MB]
    remote:        Fetched 49.6 MB in 1s (26.4 MB/s)
    remote:        Download complete and in download only mode
    remote: -----> Fetching deb packages
    remote: -----> Installing datadog-agent_1%3a5.1.0-539_amd64.deb
    remote: -----> Datadog Agent package installed
    remote: -----> Writing profile script
    remote: =====> Downloading Buildpack: https://github.com/heroku/heroku-buildpack-ruby
    remote: =====> Detected Framework: Ruby
    remote: -----> Compiling Ruby/Rack
    remote: -----> Using Ruby version: ruby-2.1.5
    remote: -----> Installing dependencies using 1.6.3
    remote:        Running: bundle install --without development:test --path vendor/bundle --binstubs vendor/bundle/bin -j4 --deployment
    remote:        Using tilt 1.4.1
    remote:        Using rack 1.5.2
    remote:        Using bundler 1.6.3
    remote:        Using puma 2.10.2
    remote:        Using rack-protection 1.5.3
    remote:        Using sinatra 1.4.5
    remote:        Your bundle is complete!
    remote:        Gems in the groups development and test were not installed.
    remote:        It was installed into ./vendor/bundle
    remote:        Bundle completed (0.52s)
    remote:        Cleaning up the bundler cache.
    remote:
    remote: Using release configuration from last framework (Ruby).
    remote: -----> Discovering process types
    remote:        Procfile declares types     -> web
    remote:        Default types for Multipack -> console, rake
    remote:
    remote: -----> Compressing... done, 64.3MB
    remote: -----> Launching... done, v9
    remote:        https://blooming-peak-9226.herokuapp.com/ deployed to Heroku
    remote:
    remote: Verifying deploy... done.
    To https://git.heroku.com/blooming-peak-9226.git
    aa392ca..7d7eed8  master -> master
    ```

    The warnings are due to the way apt-get handles being installed into a restricted environment where we cannot modify the accepting keys.

4. Add foreman to project, change how process is launched

    [This commit](https://github.com/miketheman/buildpack-example-ruby/commit/fb78b9ba6609f95d827aff9495904095ee7b795c) adds the foreman gem, an internal Procfile to launch the web worker and dogstatsd together.

    ```console
    $ git push heroku master
    Counting objects: 7, done.
    Delta compression using up to 4 threads.
    Compressing objects: 100% (6/6), done.
    Writing objects: 100% (7/7), 929 bytes | 0 bytes/s, done.
    Total 7 (delta 2), reused 0 (delta 0)
    remote: Compressing source files... done.
    remote: Building source:
    remote:
    remote: -----> Fetching custom git buildpack... done
    remote: -----> Multipack app detected
    remote: =====> Downloading Buildpack: https://github.com/miketheman/heroku-buildpack-datadog.git
    remote: =====> Detected Framework: Heroku Datadog Buildpack
    remote: -----> Updating apt caches
    remote:        Ign http://apt.datadoghq.com stable InRelease
    remote:        Get:1 http://apt.datadoghq.com stable Release.gpg [473 B]
    remote:        Hit http://apt.datadoghq.com stable Release
    remote:        Ign http://apt.datadoghq.com stable Release
    remote:        Ign http://apt.datadoghq.com stable/main amd64 Packages/DiffIndex
    remote:        Hit http://apt.datadoghq.com stable/main amd64 Packages
    remote:        Ign http://apt.datadoghq.com stable/main Translation-en_US
    remote:        Ign http://apt.datadoghq.com stable/main Translation-en
    remote:        Fetched 473 B in 0s (1,192 B/s)
    remote:        Reading package lists...
    remote: W: GPG error: http://apt.datadoghq.com stable Release: The following signatures couldn't be verified because the public key is not available: NO_PUBKEY 226AE980C7A7DA52
    remote: -----> Fetching datadog-agent
    remote:        Reading package lists...
    remote:        Building dependency tree...
    remote:        The following NEW packages will be installed:
    remote:          datadog-agent
    remote:        0 upgraded, 1 newly installed, 0 to remove and 0 not upgraded.
    remote:        Need to get 0 B/49.6 MB of archives.
    remote:        After this operation, 164 MB of additional disk space will be used.
    remote:        WARNING: The following packages cannot be authenticated!
    remote:          datadog-agent
    remote:        Download complete and in download only mode
    remote: -----> Fetching deb packages
    remote: -----> Installing datadog-agent_1%3a5.1.0-539_amd64.deb
    remote: -----> Datadog Agent package installed
    remote: =====> Downloading Buildpack: https://github.com/heroku/heroku-buildpack-ruby
    remote: =====> Detected Framework: Ruby
    remote: -----> Compiling Ruby/Rack
    remote: -----> Using Ruby version: ruby-2.1.5
    remote: -----> Installing dependencies using 1.6.3
    remote:        Running: bundle install --without development:test --path vendor/bundle --binstubs vendor/bundle/bin -j4 --deployment
    remote:        Fetching gem metadata from https://rubygems.org/..........
    remote:        Using rack 1.5.2
    remote:        Using tilt 1.4.1
    remote:        Using bundler 1.6.3
    remote:        Using puma 2.10.2
    remote:        Using rack-protection 1.5.3
    remote:        Using sinatra 1.4.5
    remote:        Installing dotenv 1.0.2
    remote:        Installing thor 0.19.1
    remote:        Installing foreman 0.76.0
    remote:        Your bundle is complete!
    remote:        Gems in the groups development and test were not installed.
    remote:        It was installed into ./vendor/bundle
    remote:        Bundle completed (4.17s)
    remote:        Cleaning up the bundler cache.
    remote:
    remote: Using release configuration from last framework (Ruby).
    remote: -----> Discovering process types
    remote:        Procfile declares types     -> web
    remote:        Default types for Multipack -> console, rake
    remote:
    remote: -----> Compressing... done, 64.4MB
    remote: -----> Launching... done, v10
    remote:        https://blooming-peak-9226.herokuapp.com/ deployed to Heroku
    remote:
    remote: Verifying deploy... done.
    To https://git.heroku.com/blooming-peak-9226.git
    + 7d7eed8...fb78b9b master -> master
    ```

    And the output from `heroku logs`:

    ```console
    2014-12-07T16:17:33.492472+00:00 heroku[api]: Deploy fb78b9b by miketheman@gmail.com
    2014-12-07T16:17:33.492500+00:00 heroku[api]: Release v10 created by miketheman@gmail.com
    2014-12-07T16:17:33.812239+00:00 heroku[web.1]: State changed from up to starting
    2014-12-07T16:17:36.848823+00:00 heroku[web.1]: Stopping all processes with SIGTERM
    2014-12-07T16:17:38.588602+00:00 heroku[web.1]: Process exited with status 143
    2014-12-07T16:17:39.860449+00:00 heroku[web.1]: Starting process with command `foreman start -f Procfile.internal`
    2014-12-07T16:17:40.876288+00:00 app[web.1]: 16:17:40 dogstatsd.1 | started with pid 5
    2014-12-07T16:17:40.875982+00:00 app[web.1]: 16:17:40 web.1       | started with pid 4
    2014-12-07T16:17:41.256061+00:00 app[web.1]: 16:17:41 web.1       | * Min threads: 0, max threads: 16
    2014-12-07T16:17:41.256278+00:00 app[web.1]: 16:17:41 web.1       | * Environment: production
    2014-12-07T16:17:41.433553+00:00 app[web.1]: 16:17:41 dogstatsd.1 | Log file is unwritable: '/var/log/datadog/dogstatsd.log'
    2014-12-07T16:17:41.255926+00:00 app[web.1]: 16:17:41 web.1       | Puma 2.10.2 starting...
    2014-12-07T16:17:41.256583+00:00 app[web.1]: 16:17:41 web.1       | * Listening on tcp://0.0.0.0:17131
    2014-12-07T16:17:41.462462+00:00 app[web.1]: 16:17:41 dogstatsd.1 | 2014-12-07 16:17:41,461 | INFO | dd.dogstatsd | dogstatsd(dogstatsd.py:105) | Reporting to app.datadoghq.com every 10s
    2014-12-07T16:17:41.462385+00:00 app[web.1]: 16:17:41 dogstatsd.1 | 2014-12-07 16:17:41,461 | INFO | dd.dogstatsd | dogstatsd(dogstatsd.py:274) | Listening on host & port: ('localhost', 8125)
    2014-12-07T16:17:41.895369+00:00 heroku[web.1]: State changed from starting to up
    ```

5. Add metrics reporting to the application

    [This commit](https://github.com/miketheman/buildpack-example-ruby/commit/1e8aa646a781f94576d40f67e4285f6a011d9b91) shows the addition of actually making a statsd callout, along with tags, so I can feasibly reuse the
    metric name `page.views` if it makes sense to aggregate all page views across all apps (tagged by default as "hosts") as well as by dyno ID, in case you're looking to spot variance of dyno performance in comparison.

6. Profit!

    ![Heroku page.views](http://cl.ly/image/01040Z2Z0j2c/page.views%20on%20heroku.png)
