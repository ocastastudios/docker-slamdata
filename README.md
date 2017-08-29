# README #

As of Slamdata 4.2.6 this image is built from the Slamdata 30 day trial download. 
The community edition appears to be no longer available.

This image can be used to run a trail instance of Slamdata or a full Slamdata instance if you have a full license. 

It is recommended you mount /root/.config/quasar/ as a named volume to persist configuration data.


#### Environment Variables ####

The image contains a script file that automatically creates an initial configuration from the following environment variables.

 - PORT: The port number that Slamdata will run on
 - ADMIN_GROUP: The name of the initial admin group
 - ADMIN_USERS: A comma separated list of usernames to belong to the admin group
 - OIDC_CLIENT_ID, OIDC_ISSUER, OIDC_NAME: OpenID connect configuration values
 - SD_OPTS: License key values to pass to the Java command that starts Slamdata. [See Slamdata docs for full details](http://docs.slamdata.com/en/latest/administration-guide.html)
 
#### Supported tags ####

* `latest`,`4.2` The most recent version of SlamData v4.2
* `4.2.x` Specific versions of SlamData v4.2