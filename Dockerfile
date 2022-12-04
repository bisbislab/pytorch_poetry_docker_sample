FROM nvidia/cuda:11.7.1-devel-ubuntu20.04

# タイムゾーン設定
ENV SHELL=/bin/bash
ENV TZ=Asia/Tokyo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

ARG USER_NAME=${USER_NAME}
ARG USER_UID=${USER_UID}
ARG USER_GID=${USER_GID}

WORKDIR /workspace
COPY pyproject.toml poetry.lock /workspace

RUN groupadd --gid $USER_GID $USER_NAME && \
    useradd --uid $USER_UID --gid $USER_GID -m $USER_NAME && \
    apt-get update &&\
    apt-get -y install --no-install-recommends locales && \
    localedef -f UTF-8 -i ja_JP ja_JP.UTF-8 && \
    apt-get -y install --no-install-recommends software-properties-common && \
    add-apt-repository ppa:deadsnakes/ppa -y && \
    apt-get -y install --no-install-recommends \
        curl \
        git \
        libgl1-mesa-dev \
        python3.10 \
        sudo && \
    echo $USER_NAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USER_NAME && \
    chmod 0440 /etc/sudoers.d/$USER_NAME && \
    curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && \
    python3.10 get-pip.py && \
    rm get-pip.py && \
    ln -s python3.10 python && \
    mv python /usr/bin/ && \
    pip install --no-cache-dir poetry && \
    poetry config virtualenvs.create false && \
    poetry install

USER $USER_NAME