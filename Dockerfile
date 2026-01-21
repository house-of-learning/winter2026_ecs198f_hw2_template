FROM debian:bookworm

ENV PATH="/opt/miniconda/bin:$PATH"

# Install wget and git
RUN apt-get update && \
    apt-get install -y wget git ca-certificates && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install miniconda
RUN arch=$(uname -m) && \
    if [ "$arch" = "x86_64" ]; then \
    MINICONDA_URL="https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh"; \
    elif [ "$arch" = "aarch64" ]; then \
    MINICONDA_URL="https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-aarch64.sh"; \
    else \
    exit 1; \
    fi && \
    wget $MINICONDA_URL -O /tmp/miniconda.sh && \
    mkdir -p /root/.conda && \
    bash /tmp/miniconda.sh -b -p /opt/miniconda && \
    rm -f /tmp/miniconda.sh

# Install repo from instructions
RUN git clone https://github.com/dbarnett/python-helloworld ./python-helloworld
