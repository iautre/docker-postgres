# docker-postgres

基于 PostgreSQL 官方镜像构建，集成 [pgvector](https://github.com/pgvector/pgvector) 向量扩展，支持多平台。

## 镜像信息

| 组件 | 版本 |
|------|------|
| PostgreSQL | 18.3 |
| Alpine | 3.23 |
| pgvector | 0.8.2 |

## 拉取镜像

```bash
docker pull iautre/postgres:latest
# 或指定版本
docker pull iautre/postgres:18.3-alpine3.23-pgvector0.8.2
```

## 启动容器

```bash
docker run -d \
  --name postgres \
  -e POSTGRES_PASSWORD=yourpassword \
  -e POSTGRES_DB=yourdb \
  -p 5432:5432 \
  iautre/postgres:latest
```

## 启用 pgvector 扩展

连接数据库后执行：

```sql
CREATE EXTENSION vector;
```

## 手动构建

```bash
docker buildx build \
  -t iautre/postgres:18.3-alpine3.23-pgvector0.8.2 \
  -t iautre/postgres:latest \
  --platform=linux/amd64,linux/arm64 \
  . --push
```

## CI/CD

推送到 `main` 分支后，GitHub Actions 会自动构建并推送多平台镜像到 Docker Hub。

需要在仓库 Settings → Secrets 中配置：

- `DOCKER_HUB_USERNAME`：Docker Hub 用户名
- `DOCKER_HUB_TOKEN`：Docker Hub Access Token
