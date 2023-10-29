FROM ubuntu:22.04

RUN apt-get update \
  && apt-get -y install \
  python3 \
  python3-pip \
  && mkdir /app/ \
  && mkdir /req/

ADD requirements.txt /req/
RUN pip install -r /req/requirements.txt

ADD app /app
ENTRYPOINT ["python3"]
