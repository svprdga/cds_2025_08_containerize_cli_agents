#!/bin/bash
# dev-claude-nh.sh

CONTAINER_NAME="dev-claude"
IMAGE_NAME="claude-dev-image"

echo "Starting Docker environment for Claude Code..."

# Build image if it doesn't exist
if ! docker image inspect $IMAGE_NAME >/dev/null 2>&1; then
    echo "Building Docker image..."
    docker build -f claude/Dockerfile -t $IMAGE_NAME .
fi

# If the container already exists, reuse it
if docker ps -a --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}$"; then
    echo "Reusing existing container..."
    docker start -ai $CONTAINER_NAME
else
    echo "Creating new container..."

    docker run -it \
        --name "$CONTAINER_NAME" \
        -v "$(pwd):/workspace" \
        --memory="4g" \
        --cpus="2" \
        $IMAGE_NAME \
        /bin/bash
fi

echo "Container finished."
