FROM nvidia/cuda:11.7.1-devel-ubuntu20.04

# タイムゾーン設定
ENV TZ=Asia/Tokyo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# localeとpython3.10インストール用の設定
RUN apt-get update &&\
    apt-get -y install --no-install-recommends locales && \
    localedef -f UTF-8 -i ja_JP ja_JP.UTF-8 && \
    apt-get -y install --no-install-recommends software-properties-common && \
    add-apt-repository ppa:deadsnakes/ppa -y

RUN apt-get -y install --no-install-recommends \
        curl \
        git \
        python3.10

# Python環境設定
RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && \
    python3.10 get-pip.py && \
    rm get-pip.py && \
    ln -s python3.10 python && \
    mv python /usr/bin/

WORKDIR /workspace
COPY pyproject.toml poetry.lock /workspace
RUN pip install --no-cache-dir poetry && \
    poetry config virtualenvs.create false && \
    poetry install