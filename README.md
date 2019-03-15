# isofit_docker
A repository for building an isofit (https://github.com/isofit/isofit) Docker container

Docker hub location: https://hub.docker.com/r/serbinsh/isofit_containers

### Instructions for running the LibRadTran example:

1) Install the Docker engine: https://www.docker.com/get-started

<br>

2) Pull down the latest version of the basic isofit Docker container <br>
```docker pull serbinsh/isofit_containers:isofit_master_latest```

<br>

3) Launch the IsoFit example run using the providing example shell script
```
docker run -t -i --user isofit -v ~/scratch/isofit_output:/isofit/examples/20171108_Pasadena/output -v ~/scratch/isofit_output/images:/isofit/examples/20171108_Pasadena/images -v ~/scratch/isofit_output/lut:/isofit/examples/20171108_Pasadena/lut serbinsh/isofit_containers:isofit_master_latest /bin/sh -c 'cd /isofit/examples/20171108_Pasadena && mkdir -p lut && ./run_example_libradtran.sh'
```
* Note in this case we are mapping the isofit output in the Docker container (/isofit/examples/20171108_Pasadena/output) to the ~/scratch/isofit_output folder on the host machine.

<br>

4) View output in the folder ~/scratch/isofit_output. Example you will find figures in the ~/scratch/isofit_output/images

<br>

![Example IsoFit Output Frame](https://raw.githubusercontent.com/serbinsh/isofit_docker/master/graphics/frame_0.png?raw=true "Example IsoFit Output Frame")
