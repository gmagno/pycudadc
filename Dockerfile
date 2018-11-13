FROM nvidia/cudagl:9.0-devel-ubuntu16.04

ENV NVIDIA_DRIVER_CAPABILITIES ${NVIDIA_DRIVER_CAPABILITIES},display

ENV PYTHONFAULTHANDLER=1 \
    PYTHONUNBUFFERED=1 \
    PYTHONHASHSEED=random \
    PIP_NO_CACHE_DIR=off \
    PIP_DISABLE_PIP_VERSION_CHECK=on \
    PIP_DEFAULT_TIMEOUT=100 \
    PIPENV_HIDE_EMOJIS=true \
    PIPENV_COLORBLIND=true \
    PIPENV_NOSPIN=true \
    PYTHONPATH=/app \
    LC_ALL=C.UTF-8 \
    LANG=C.UTF-8 \
    DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
        cuda-samples-$CUDA_PKG_VERSION \
        mesa-utils \
        libmtdev1 \
        libsdl2-dev \
        python3-dev \
        python3-pip \
        python3-tk && \
    rm -rf /var/lib/apt/lists/*

RUN pip3 install --upgrade pip pipenv

RUN mkdir /root/app
WORKDIR /root/app
COPY . .
RUN pipenv install --dev --deploy --system --ignore-pipfile

CMD ["python3", "gol.py", "200", "50"]
