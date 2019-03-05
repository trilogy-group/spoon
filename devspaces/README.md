# Development with Devspaces

### Devspaces 

Manage your Devspaces https://www.devspaces.io/.

Read up-to-date documentation about cli installation and operation in https://www.devspaces.io/devspaces/help.

Here follows the main commands used in Devspaces cli. 

|action   |Description                                                                                      |
|---------|-------------------------------------------------------------------------------------------------|
|`devspaces --help`                       |Check the available command names.                               |
|`devspaces create [options]`             |Creates a DevSpace using your local DevSpaces configuration file |
|`devspaces start trilogy-spoon`          |Starts the DevSpace named \[trilogy-spoon\]                      |
|`devspaces bind trilogy-spoon`           |Syncs the DevSpace with the current directory                    |
|`devspaces info trilogy-spoon [options]` |Displays configuration info about the DevSpace.                  |

Use `devspaces --help` to know about updated commands.

#### Development flow

You should have Devspaces cli services started and logged to develop with Devspaces.
The following commands should be issued from **project directory**.

1 - Create Devspaces

```bash
$ cd devspaces/docker
$ devspaces create
$ cd ../../
```

2 - Start containers

```bash
devspaces start trilogy-spoon
```

3 - Start containers synchronization

```bash
devspaces bind trilogy-spoon
```

4 - Grab some container info

```bash
devspaces info trilogy-spoon
```

Retrieve published DNS and endpoints using this command

5 - Connect to development container

```bash
devspaces exec trilogy-spoon
```

6 - Build Spoon

```bash
mvn compile
```

7 - Test Spoon

```bash
mvn test
`

### Docker Script Manager (CLI)

Currently, we have these command available to work using local docker compose.

```bash
devspaces/docker-cli.sh <command>
```

|action    |Description                                                               |
|----------|--------------------------------------------------------------------------|
|`build`   |Builds images                                                             |
|`deploy`  |Deploy Docker compose containers                                          |
|`undeploy`|Undeploy Docker compose containers                                        |
|`start`   |Starts Docker compose containers                                          |
|`stop`    |Stops Docker compose containers                                           |
|`exec`    |Get into the container                                                    |

#### Development flow

1 - Build and Run `docker-compose` locally.

```bash
devspaces/docker-cli.sh build
devspaces/docker-cli.sh deploy
devspaces/docker-cli.sh start
```

2 - Get into container

```bash
devspaces/docker-cli.sh exec
```

3 - Build Spoon

```bash
mvn compile
```

4 - Test Spoon

```bash
mvn test

Please refer to [Spoon Readme](../../README.md) doc for more details on the building and testing the project.