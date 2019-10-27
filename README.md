# Docker in Docker plus Docker Compose
Docker in docker `19.03.4` with docker-compose `1.24.1` and git support, tested and used in `.gitlab-ci.yml` pipeline.

```bash
# docker-compose --version
docker-compose version 1.24.1, build 4667896
```

##  Gitlab-ci boilerplate
`.gitlab-ci.yml` working example: builds an image and pushes it to gitlab's container registry. Notice the usage of cache to reduce build time.

```yaml
variables:
  SLUG_APP_IMAGE_DEV_TAG: $CI_REGISTRY_IMAGE/java:dev

stages:
  - build

docker-build-dev:
  image: guglio/dind-compose:test
  stage: build
  services:
    - docker:19.03.4-dind
  before_script:
    - docker login -u "$CI_REGISTRY_USER" -p "$CI_REGISTRY_PASSWORD" $CI_REGISTRY
    - git clone https://myPrivateDependency ./dependencies/xyz
  script:
    - docker pull $SLUG_APP_IMAGE_DEV_TAG || true
    - docker build --cache-from $SLUG_APP_IMAGE_DEV_TAG --tag $SLUG_APP_IMAGE_DEV_TAG ./java
    - docker push "$SLUG_APP_IMAGE_DEV_TAG"
  only:
    - dev
```
