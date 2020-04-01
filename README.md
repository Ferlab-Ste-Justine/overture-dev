# About

This project contains the orchestration for the reusable core components of the Overture projects used at the Sainte-Justine Chu.

To get a fully running setup, you'll need some project-specific complementary services (such as id service), like those that can be found here for the Clin project: https://github.com/cr-ste-justine/overture-dev-clin

# Usage

## Running the Services

To launch and close the services in dev:

Launch:
```
./launch-services.sh
```

Teardown:
```
./teardown-services.sh
```

To launch and close a more prodlike version (images pulled instead of built locally, minimal container-host port bindings):

Set your environment to prodlike:
```
export ENV=prodlike
```

Then, run the same commands as before to launch and tear down the services

## Reloading Environment For Local Development

The overture auth proxies have a development image that will automatically reload in dev mode with code changes and only need to be manually reloaded when contend in the package.json or the dockerfiles change.

However, the SONG and Score overture service were written by a third party and we haven't adapted them yet to reload automatically so they will always have to be manually reloaded on code change.

To reload manually, you basically have to take down the services and spin them back up (the launch script will build the images) by typing:

```
./teardown-services.sh
./launch-services.sh
```

Note that because images layer caching, only images that have actually changed will take time to rebuild. The others should be near-instantaneous to build.

## Pushing Images

If you are part of the Chu team and need to build and push a new version of the images, run:

```
./push-images.sh
```

Note that you'll need to be logged in with an account that has permission to push to our repos on docker hub.