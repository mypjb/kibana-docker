FROM centos

MAINTAINER mypjb/kibana docker maintainer 280417314@qq.com

# log stash download url
ENV KIBANA_URL https://artifacts.elastic.co/downloads/kibana/kibana-5.4.0-linux-x86_64.tar.gz

# log stash git
ENV KIBANA_GIT https://github.com/mypjb/kibana-docker.git

#log stash install dir
ENV KIBANA_PATH /usr/local/kibana
#log conf dir
ENV KIBANA_CONF /usr/local/kibana/config

#es url
ENV ES_URL "1"         

#COPY kibana.tar.gz ./

RUN yum update -y \
        && yum install -y net-tools wget git   

RUN wget $KIBANA_URL -O kibana.tar.gz

RUN mkdir -p $KIBANA_PATH \
	&& tar -xzf kibana.tar.gz -C $KIBANA_PATH --strip-components=1 \
        && rm -rf kibana.tar.gz \
        && cd $KIBANA_PATH \
        && git clone $KIBANA_GIT  git \
        && cp git/config/* config \
        && ln -s $KIBANA_PATH/bin/kibana /usr/local/bin

EXPOSE 5601

CMD  sed -i "s%\$ES_URL%$ES_URL%" $KIBANA_PATH/config/kibana.yml ;  \
	kibana ; \
        /bin/bash
