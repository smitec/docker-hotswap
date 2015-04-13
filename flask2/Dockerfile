FROM ubuntu:14.04
MAINTAINER Elliot Smith (elliot.smith91@gmail.com)

# make sure we're up to date
RUN apt-get update --fix-missing

RUN apt-get install -y build-essential
RUN apt-get install -y python3 python-pip python-virtualenv

RUN virtualenv /opt/venv
ADD ./requirements.txt /opt/venv/requirements.txt
# gunicorn should be one such item in requierments or this will fail
RUN /opt/venv/bin/pip install -r /opt/venv/requirements.txt

ADD /src /opt/src

WORKDIR /opt/src/

EXPOSE 8000

CMD ["/opt/venv/bin/gunicorn", "testing:app", "-b 0.0.0.0:8000"]
