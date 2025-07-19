FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# 1. Install system packages
RUN apt-get update && apt-get install -y \
    git \
    curl \
    wget \
    python3 \
    python3-dev \
    python3-pip \
    python3-venv \
    software-properties-common \
    mariadb-server \
    mariadb-client \
    redis-server \
    supervisor \
    build-essential \
    xvfb \
    libfontconfig \
    libxrender1 \
    libxext6 \
    libx11-dev \
    libffi-dev \
    libssl-dev \
    libjpeg-dev \
    zlib1g-dev \
    liblcms2-dev \
    libblas3 \
    liblapack3 \
    locales \
    cron \
    && rm -rf /var/lib/apt/lists/*

# 2. Locale
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# 3. Node.js 18 & Yarn
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g yarn && \
    rm -rf /var/lib/apt/lists/*

# 4. Install Bench CLI
RUN pip3 install frappe-bench

# 5. Create user & init bench
RUN useradd -m -s /bin/bash frappe
USER frappe
WORKDIR /home/frappe
RUN bench init --skip-redis-config-generation --frappe-branch version-15 frappe-bench

# 6. Copy entrypoint
USER root
COPY entrypoint.sh /home/frappe/frappe-bench/entrypoint.sh
RUN chmod +x /home/frappe/frappe-bench/entrypoint.sh
RUN chown frappe:frappe /home/frappe/frappe-bench/entrypoint.sh

# 7. Switch to frappe
USER frappe
WORKDIR /home/frappe/frappe-bench

CMD ["./entrypoint.sh"]

