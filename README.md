Mockr
======

Mockr is a design mocking application, which makes it easy for teams to share, annotate and review designs.

It can be hosted standalone or on [Bushido](http://bushi.do)

If you want to install the app on localhost: rake app:install
On Bushido, the same rake task is aliased as rake bushido:install

Local support isn't that great. Bushido support is priority for now, so please be patient.

Notes
------

The following notes were in the README before modifying/maintaining. Although none of these would be necessary right now. This is just for historic purposes.

#### Setup

1) Copy bin-examples/ to bin/ and edit each file to contain your app's values.
2) Install necessary gems using bundler.
3) Setup db: rake db:create; rake db:migrate

#### Running mockr in dev

Make sure you source ./bin/export-env-vars-for-dev to set up your environment
variables before starting the app.
  $ source ./bin/export-env-vars-for-dev
