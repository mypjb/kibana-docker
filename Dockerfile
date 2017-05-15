#log conf dir
ENV KIBANA_CONF /usr/local/kibana/config

ENV ES_URL 1         

COPY kibana.tar.gz ./

RUN yum update -y \
        && yum install -y net-tools wget git   

#RUN wget $KIBANA_URL -O kibana.tar.gz

RUN tar -xzf kibana.tar.gz -C $KIBANA_PATH --strip-components=1 \
        && rm -rf kibana.tar.gz \
        && CD $KIBANA_PATH \
        && wget $KIBANA_GIT -O git \
        && cp git/config/* config \
        && ln -s $KIBANA_PATH/bin/kibana /usr/local/bin

CMD if test $ES_URL -nq 1 ; then sed -i	"s/\$ES_URL/$ES_URL" $KIBANA_PATH/config/kibana.yml ; \
        kibana \
        /bin/bash
