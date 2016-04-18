# DockerImage

In this project, I have delineated the steps to create a docker image. In case you're not familiar with Docker, here's a brief [Overview of Docker](https://docs.docker.com/engine/understanding-docker/)

> Note: This tutorial uses version **1.11.0** of Docker. If you find any part of the tutorial incompatible with a future version, please raise an issue. Thanks!


### Prerequisites
-----------------
#### Docker
The *getting started* guide on Docker has detailed instructions for setting up Docker on [Mac](http://docs.docker.com/mac/step_one/), [Linux](http://docs.docker.com/linux/step_one/) and [Windows](http://docs.docker.com/windows/step_one/).

Once you are done installing Docker, test your Docker installation by running the following:
```
$ docker run hello-world

Hello from Docker.
This message shows that your installation appears to be working correctly.
...
```

##### Python
Python comes pre-installed on OSX and (most) Linux distributions.

If don't have pip installed, please [download](http://pip.readthedocs.org/en/stable/installing/) it for your system.
```
$ python --version
python --version
Python 2.7.10

$ pip --version
pip 7.1.2 from /Library/Python/2.7/site-packages/pip-7.1.2-py2.7.egg (python 2.7)
```
##### Java (optional)
The app that we'll be using Java based web application. The tutorial will run everything inside a container so having Java locally is not strictly required. If Java is installed, typing `java -version` in your terminal should give you an output similar to the one below.

```
$ java -version
java version "1.8.0_60"
Java(TM) SE Runtime Environment (build 1.8.0_60-b27)
Java HotSpot(TM) 64-Bit Server VM (build 25.60-b23, mixed mode)
```
___________

## Webapps with Docker
Now that we have looked at `docker run`, let's deploy web applications with docker. We can download and run the image directly in one go using `docker run`.

```
$ docker run -it -p 8080:8080 niteshch/twitter-map
```
Since the image doesn't exist locally, the client will first fetch the image from the registry and then run the image. This image launches pre-configured Java based web application inside a tomcat container. This application loads a Twitter heat map and at the bottom of the page, loads a bar chart which displays distribution of tweets based on the keywords.

The above docker command specifies host port and container port as follows: 
```
docker run -p hostPort:containerPort imageName
```
When running twitter-map image, we are using 8080 as host port. Since the tomcat container by default uses 8080 port, we are using the container port as 8080.

If you're on linux, you can now access the Twitter Heat Map web application using [http://localhost:8080/TwitterStream/index.html](http://localhost:8080/TwitterStream/index.html)

If you're on Windows or a Mac, you need to find the IP of the hostname.

```
$ docker-machine ip default
192.168.99.100
```
Based on above output, you can now open http://192.168.99.100:8080/TwitterStream/index.html to see your Twitter Heat Map.
Kill the above running image.

### Build Your Own Docker Image
Now we will build our own image using a [Dockerfile](https://docs.docker.com/engine/reference/builder/). I have added the Dockerfile and the TwitterHeatMap.war used in this example to the repository.

Let me deconstruct the Dockerfile. The first line of the Dockerfile, specifies the base image that we're going to use.
```
FROM tomcat:8.0.33-jre8
```
Then we copy the TwitterHeatMap.war file to the `webapps` directory of the tomcat server.
```
COPY ./TwitterStream.war /usr/local/tomcat/webapps/TwitterStream.war
```
You can now build the image. The `docker build` command does the heavy-lifting of creating a docker image from a `Dockerfile`.

```
$ docker build -t twitter-map .
Sending build context to Docker daemon 2.048 kB
Step 1 : FROM tomcat:8.0.33-jre8
8.0.33-jre8: Pulling from library/tomcat
efd26ecc9548: Pull complete 
a3ed95caeb02: Pull complete 
d1784d73276e: Pull complete 
52a884c93bb2: Pull complete 
070ee56a6f7e: Pull complete 
f8b8b1302b4f: Pull complete 
e71221cc9598: Pull complete 
349c9e35d503: Pull complete 
43030ae83c61: Pull complete 
59a62fdf179f: Pull complete 
0563acdc7146: Pull complete 
Digest: sha256:7470af83c7df3c94226b745b626cd3da0d447e8e7e6f9983175c1a1de781288c
Status: Downloaded newer image for tomcat:8.0.33-jre8
 ---> b492eded2af3
Step 2 : COPY ./TwitterStream.war /usr/local/tomcat/webapps/TwitterStream.war
 ---> 54662dcfb5ca
Removing intermediate container 86870d6ee9e1
Successfully built 54662dcfb5ca
```

You can now run the image and see if it actually works.
```
$ docker run -it -p 8080:8080 twitter-map
```

If you're on linux, you can now access the Twitter Heat Map web application using [http://localhost:8080/TwitterStream/index.html](http://localhost:8080/TwitterStream/index.html)

If you're on Windows or a Mac, you need to find the IP of the hostname.

```
$ docker-machine ip default
192.168.99.100
```
Based on above output, you can now open http://192.168.99.100:8080/TwitterStream/index.html to see your Twitter Heat Map.

In order to push the image to your account on [Docker Hub](https://docs.docker.com/linux/step_five/), follow the instructions of [tagging and pushing your images](https://docs.docker.com/linux/step_six/) to Docker Hub
