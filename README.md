# Symfony project manager

Docker images build to manage symfony project with different php version.

## Docker hub
https://hub.docker.com/r/glefer/symfony-project-manager

## Getting Started

These instructions will cover usage information and for the docker container

### Prerequisities


In order to run this container you'll need docker installed.

* [Windows](https://docs.docker.com/windows/started)
* [OS X](https://docs.docker.com/mac/started/)
* [Linux](https://docs.docker.com/linux/started/)

### Usage

#### Create new project
To create a new project, you can use the follow  command
``` bash
docker run --rm -it -v $PWD:/app  glefer/symfony-project-manager:8.1.7 new  :projectName
```

## Authors

* **Gregory LEFER** - *Lead dev* - [GleItroom](https://github.com/gleitroom)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.
