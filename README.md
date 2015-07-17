# oracle-eclipse-ee
Dockerized oracle instance, running by oracle java

Contains:
- Oracle JDK8 (1.8.0_20)
- Maven 3.0.5
- Eclipse Luna SR1a for EE developers (http://eclipse.org/downloads/packages/eclipse-ide-java-ee-developers/lunar)
- Initialized with Lombok (http://projectlombok.org/)

## Build
Just run
<pre>sudo docker build .</pre>

## Run
<pre>sudo docker run -ti --rm \
    -e DISPLAY=$DISPLAY \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v [type here your workspace path]:/workspace \
    -v [type here your m2 cache path]:/home/eclipse/.m2 \
    gceranto/oracle-eclipse-ee</pre>
    
## Eclipse doesn't start?
Probably you have some X11 socket permission issue.
Try with `xhost +` to enable to all users and restart container.
