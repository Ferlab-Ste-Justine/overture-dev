FROM overture/local-base-ubuntu:latest
MAINTAINER OVERTURE <contact@overture.bio>

ENV AUTH_INIT $DCC_HOME/init
ENV AUTH_DATA $DCC_HOME/auth_data
ENV SIMPLE_AUTH_ROOT $DCC_HOME/SimpleAuth

ADD init $AUTH_INIT

RUN git clone https://github.com/andricDu/SimpleAuth $SIMPLE_AUTH_ROOT && \
	pip3 install -r $SIMPLE_AUTH_ROOT/requirements.txt

RUN mkdir -p /opt/dcc/auth_data

CMD $AUTH_INIT/run.sh $AUTH_PORT


