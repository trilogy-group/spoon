FROM ubuntu:18.04

ADD setup.sh /
RUN chmod +x setup.sh && ./setup.sh

WORKDIR /data

CMD tail -f /dev/null