# lixee-dk6programmer-docker
Docker image for DK6Programmer to flash LiXee devices

* This project allows to flash a LiXee devices with a single line of code.
* Firmware files are supported as URL or local file, in native (bin/hex) and zipped format.

## Usage
### docker-compose
1. Create a `compose.yaml` for your environment, based on the [compose.yaml](compose.yaml) example file
1. Run `docker-compose run --rm lixee-dk6programmer`

## Requirements
### Software
* Required: Docker
* Required: Docker Compose

The Docker Compose [documentation](https://docs.docker.com/compose/install/)
contains a comprehensive guide explaining several install options. On recent debian-based systems, Docker Compose may be installed by calling
  ```sh
  $ sudo apt install docker-compose
  ```

## References
* This project is an integration of
  * [Update instructions for LiXee devices](https://zigate.fr/documentation/mise-a-jour-de-la-zigate-2/)
  * [Docker](https://www.docker.com)