# Task 1. MongoDB sharding

## Prerequisites

Install docker and docker-compose.

## Links:
* https://docs.docker.com/compose/compose-file
* https://hub.docker.com/_/mongo

## Description:

* Pull docker image "mongo".
* Create docker-compose.yaml for containers:
  * mongo (one port forwarding, with mongos main process)
  * mongo (no port forwarding, config servers process)
  * mongo (no port forwarding, data servers process)
  * mongo (no port forwarding, data replica servers process)
* Scale "mongo config server" containers up to 3. 
* Scale "mongo data server containers" up to 4.
* Scale "mongo data replica server" 2 for each "mongo config server".
* Make a secure connection between all "mongo server's".
* Deploy containers and test the result.
  
## Goals

* Setup configuration for docker-compose file
* Make sure the configuration is correct 
* Become experience with mongo cli and mongo configuration

## Installation

1. Navigate to **directory with compose file** and create `key-file` for nodes to authenticate themselves:

    ```shell
    $ openssl rand -base64 700 > secret.key 
    $ chmod 400 secret.key 
    $ sudo chown 999:999 secret.key
    ```

2. Create and start `containers`:

    ```shell
    $ docker-compose up -d
    ```

3. Run `setup`:

    ```shell
    $ sudo chmod +x setup.sh
    $ ./setup.sh
    ```

4. Check access with `credentials`:

    ```text
    host: localhost
    port: 27016
    user: admin
    pass: secret
    ```
