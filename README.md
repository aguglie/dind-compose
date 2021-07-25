# Docker in Docker plus Docker Compose
Docker in docker `19.03.4` with docker-compose `1.24.1` and git support, tested and used in `.gitlab-ci.yml` pipeline.

```bash
# docker-compose --version
docker-compose version 1.24.1, build 4667896
```

##  Gitlab-ci boilerplate
`.gitlab-ci.yml` working example: builds an image and pushes it to gitlab's container registry.

```yaml
stages:
  - build

docker-build-master:
  image: guglio/dind-compose:latest
  stage: build
  services:
    - docker:19.03.4-dind
  before_script:
    - docker login -u "$CI_REGISTRY_USER" -p "$CI_REGISTRY_PASSWORD" $CI_REGISTRY
  script:
    - docker build --tag "$CI_REGISTRY_IMAGE" .
    - docker push "$CI_REGISTRY_IMAGE"
  only:
    - master
```
