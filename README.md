![](https://github.com/cr-ste-justine/overture-dev/workflows/Build%20External%20Reverse%20Proxy/badge.svg)
![](https://github.com/cr-ste-justine/overture-dev/workflows/Build%20Throwaway%20Dependency/badge.svg)
![](https://github.com/cr-ste-justine/overture-dev/workflows/Publish%20External%20Reverse%20Proxy/badge.svg)
![](https://github.com/cr-ste-justine/overture-dev/workflows/Publish%20Throwaway%20Dependency/badge.svg)


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

## Interaction with the system

SONG and Score are accessible via port **10000** and port **10001** of the machine the **external-proxy** runs on in addition to directly on the **external-proxy** service via the **overture** network.

Those ports require authentication, are access-controlled and some routes deemed internal-only may be unavailable.

Additionally, SONG and Score can be accessed internally without restrictions on the port **8888** of the **song-reverse-proxy** and **score-reverse-proxy** services on the **overture** network.

Access via this mean should be dealt with extreme care as all access control considerations are delegated to the caller... You have a shotgun and you can shoot yourself in the foot so take care not to do so.

## Reloading Environment For Local Development

The overture auth proxies have a development image that will automatically reload in dev mode with code changes and only need to be manually reloaded when contend in the package.json or the dockerfiles change.

However, the SONG and Score overture service were written by a third party and we haven't adapted them yet to reload automatically so they will always have to be manually reloaded on code change.

To reload manually, you basically have to take down the services and spin them back up (the launch script will build the images) by typing:

```
./teardown-services.sh
./launch-services.sh
```

Note that because images layer caching, only images that have actually changed will take time to rebuild. The others should be near-instantaneous to build.