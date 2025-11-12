FROM debian:bookworm

# Install dependencies for pyenv, Node.js, AWS CLI, and general dev tools
RUN apt-get update && apt-get install -y \
    curl \
    unzip \
    zip \
    git \
    build-essential \
    libssl-dev \
    zlib1g-dev \
    libbz2-dev \
    libreadline-dev \
    libsqlite3-dev \
    wget \
    llvm \
    libncurses5-dev \
    libncursesw5-dev \
    xz-utils \
    tk-dev \
    libffi-dev \
    liblzma-dev \
    python3-openssl \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Install AWS CLI v2
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip \
    && ./aws/install \
    && rm -rf awscliv2.zip aws

# Install nvm and Node.js
ENV NVM_DIR /root/.nvm
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash \
    && . "$NVM_DIR/nvm.sh" \
    && nvm install --lts \
    && nvm use --lts \
    && nvm alias default 'lts/*'
ENV NODE_PATH $NVM_DIR/versions/node/$(ls $NVM_DIR/versions/node/)/lib/node_modules
ENV PATH $NVM_DIR/versions/node/$(ls $NVM_DIR/versions/node/)/bin:$PATH


# Install pyenv and Python 3.12.0
RUN git clone https://github.com/pyenv/pyenv.git /root/.pyenv \
    && /root/.pyenv/bin/pyenv install 3.12.0 \
    && /root/.pyenv/bin/pyenv global 3.12.0
ENV PYENV_ROOT /root/.pyenv
ENV PATH $PYENV_ROOT/bin:$PATH
RUN echo 'eval "$(pyenv init -)"' >> /root/.bashrc

CMD ["bash"]
