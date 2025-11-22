FROM ubuntu:24.04

# Avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Install only the essentials for any CLI agent
RUN apt-get update && apt-get install -y \
  curl \
  git \
  unzip \
  && rm -rf /var/lib/apt/lists/*

# Install Node.js for Claude Code
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
  && apt-get install -y nodejs \
  && rm -rf /var/lib/apt/lists/*

# Use a non-root user
USER ubuntu
WORKDIR /home/ubuntu

# Configure npm to install global packages in user's home directory
RUN mkdir -p /home/ubuntu/.npm-global
ENV NPM_CONFIG_PREFIX=/home/ubuntu/.npm-global
ENV PATH="$NPM_CONFIG_PREFIX/bin:$PATH"

# Install Claude Code as ubuntu user
RUN npm install -g @anthropic-ai/claude-code

# Workspace where the CLI agent will live
WORKDIR /workspace

# Default command when entering the container
CMD ["/bin/bash"]
