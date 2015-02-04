FROM jamesdbloom/docker-java8-maven
MAINTAINER Gabriele Ceranto

RUN apt-get update
RUN apt-get install -y libgtk2.0-0 libcanberra-gtk-module

# Install Eclipse
RUN export uid=1000 gid=1000 && \
	mkdir -p /home/eclipse && \
	echo "eclipse:x:${uid}:${gid}:Developer,,,:/home/eclipse:/bin/bash" >> /etc/passwd && \
	echo "eclipse:x:${uid}:" >> /etc/group && \
	echo "eclipse ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/eclipse && \
	chmod 0440 /etc/sudoers.d/eclipse && \ 
	chown ${uid}:${gid} -R /home/eclipse

RUN cd ~ && \
	wget http://eclipse.mirror.garr.it/mirrors/eclipse/technology/epp/downloads/release/luna/SR1a/eclipse-jee-luna-SR1a-linux-gtk-x86_64.tar.gz && \
	tar -xzvf eclipse-jee-luna-SR1a-linux-gtk-x86_64.tar.gz && \
	rm eclipse-jee-luna-SR1a-linux-gtk-x86_64.tar.gz && \
	mv eclipse /opt/

RUN mkdir -p /home/eclipse/workspace
RUN mkdir -p /home/eclipse/.m2
RUN chown eclipse:eclipse -R /home/eclipse && chown eclipse:eclipse -R /home/eclipse/.m2 && chown eclipse:eclipse -R /opt/eclipse

# Install Lombok
RUN wget http://projectlombok.org/downloads/lombok.jar && java -jar lombok.jar install /opt/eclipse/

USER eclipse
ENV HOME /home/eclipse
ENV PATH /home/eclipse/eclipse:$PATH

VOLUME ["/home/eclipse/workspace"]
VOLUME ["/home/eclipse/.m2"]

WORKDIR /home/eclipse

CMD ["/opt/eclipse/eclipse", "-data", "/home/eclipse/workspace"]
