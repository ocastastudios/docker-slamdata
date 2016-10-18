# SlamData Community Edition Docker Image

Builds a Docker image for the [SlamData](http://slamdata.com)  NOSQL analytics Tool (Community Edition). 

There are three environment variables that can be used to configure the image.

__PORT__
The TCP port that the SlamData server is available on. Defaults to _8080_

__CONNECTION_NAME__
The name of the preconfigured SlamData MongoDB connection. Defaults to _MongoDB_

__CONNECTION_URI__
The MongoDB connection string to be used for the initial connection. Defaults to _mongodb://mongodb:27017_

This is not an official image.


# Run SlamData

```bash
docker run -d \
           -e CONNECTION_NAME="my_connection_name" \
           -e CONNECTION_URI="mongodb://user:pass@mongo:27017/admin" \
           -p 0.0.0.0:80:8080 \
           ocasta/slamdata
```

## Run it preserving quasar config data 

Preserve quasar configuration and data by mounting the destination dir `/root/.config/quasar` from your host, data container...

Example: 

Create the dir `/root/slamdata/` in your host and run the container:

 ```bash
docker run -d \
           -e CONNECTION_NAME="my_connection_name" \
           -e CONNECTION_URI="mongodb://user:pass@mongo:27017/admin" \
           -v /root/slamdata:/root/.config/quasar
           -p 0.0.0.0:80:8080 \
           ocasta/slamdata
```

## Running Slam Advanced Edition

For obvious reasons, this image does not contain the necessary Quasar file to run Slamdata Advanced Edition. 
However if you have paid for the Advanced edition it is possible to run it with this image. 

- First download and unzip the Slamdata Advanced edition installer
- Make sure the quasar.jar file from this to somewhere the docker container will be able to access it
- Create a quasar config file with the OIDC provider configuration as in the Slamdata documentation
- Run the docker container as follows. Assuming the _quasar-config.json_ is in _/root/slamdata_ and Slamdata Advanced was 
  unzipped in _/slamdata-advanced_ the docker command would be:

 ```bash
docker run -d \
           -e ADMIN_GROUP="myAdminGroup" \
           -e ADMIN_USERS="adminuser1@myodic.com,adminuser2@myoidc.com" \
           -e SD_OPTS="-D..." |
           -v /root/slamdata:/root/.config/quasar |
           -v /slamdata-advanced:/slamdata |
           -p 0.0.0.0:80:8080 \
           ocasta/slamdata run-advanced.sh
```

where *SD_OPTS* is the Advanced edition licence parameters detailed in the Slam Documentation.

This will also write the H2 metastore to the /root/slamdata directory thus ensuring its continued existence between 
 container updates.

# Quasar REPL

The Quasar REPL jar file is included in the image although not required by Slamdata as it's so darn useful
You can fire up REPL in a running container using the same configuration as Slamdata. e.g.

    docker exec -it slamdata_container bash -c "java -jar slamdata/quasar-repl-assembly.jar -c /root/.config/quasar/quasar-config.json"
    
# Supported tags

* `latest`,`4.0` The most recent version of SlamData Community Edition v4.0
* `3.0.x` Specific versions of SlamData Community Edition v3.0
* `4.0.x` Specific versions of SlamData Community Edition v4.0

