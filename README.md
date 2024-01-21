## build
docker buildx build -t iautre/postgres:16.1-alpine3.19-pgvector --platform=linux/amd64,linux/arm64 . --push