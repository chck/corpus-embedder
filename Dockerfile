FROM python:3.6.4

RUN apt-get update && \
      apt-get install -y --no-install-recommends \
      unzip \
      wget \
      build-essential \
      cmake \
      xz-utils \
      file \
      git \
      mecab \
      libmecab-dev \
      mecab-ipadic-utf8 && \
      apt-get clean && \
      rm -rf /var/lib/apt/lists/*

RUN git clone --depth 1 https://github.com/neologd/mecab-ipadic-neologd.git /tmp/neologd && \
      cd /tmp/neologd && \
      ./bin/install-mecab-ipadic-neologd -n -u -y && \
      rm -rf /tmp/neologd

ENV MECAB_DICDIR=/usr/lib/mecab/dic/mecab-ipadic-neologd

RUN wget https://github.com/facebookresearch/fastText/archive/v0.1.0.zip -P /tmp/fasttext/ && \
      cd /tmp/fasttext && \
      unzip v0.1.0.zip && \
      cd fastText-0.1.0 && \
      make && \
      cp ./fasttext /usr/local/bin/ && \
      rm -rf /tmp/fasttext

COPY run-embedder.sh /tmp/

CMD ["sh", "/tmp/run-embedder.sh"]

