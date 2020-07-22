FROM ubuntu

EXPOSE 5000

RUN apt-get update -y
RUN apt-get install python3-venv python3-pip -y
RUN mkdir /opt/test-jenkins-docker/src/ -p
COPY src/ /opt/test-jenkins-docker/src/
COPY requirements.txt /opt/test-jenkins-docker/
RUN pip3 install -r /opt/test-jenkins-docker/requirements.txt

COPY docker-entrypoint.sh /

ENTRYPOINT "/docker-entrypoint.sh"
