FROM ubuntu:18.04

ENV DCC_HOME /opt/dcc
ENV DCC_DATA /opt/dcc/data
ENV DCC_CONFIG /opt/dcc/config
ENV AUTH_INIT $DCC_HOME/init
ENV AUTH_DATA $DCC_HOME/auth_data
ENV SIMPLE_AUTH_ROOT $DCC_HOME/SimpleAuth

RUN apt-get update && apt-get install -y git python3-pip curl

ADD init $AUTH_INIT

RUN git clone https://github.com/andricDu/SimpleAuth $SIMPLE_AUTH_ROOT && \
	pip3 install -r $SIMPLE_AUTH_ROOT/requirements.txt

RUN mkdir -p /opt/dcc/auth_data

CMD $AUTH_INIT/run.sh $AUTH_PORT

HEALTHCHECK --interval=10s --timeout=10s --start-period=30s --retries=3 CMD curl -f http://localhost:8084/admin/login/