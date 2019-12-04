#!/bin/bash

setup_common() {
    export HTCI_COMMIT_SHA=${CI_COMMIT_SHA:0:7}

    GITLAB_DOMAIN=$(echo $CI_REPOSITORY_URL | sed 's#^.*@##g;s#\/.*$##g')
    GITLAB_CREDENTIAL=$(echo $CI_REPOSITORY_URL | sed "s;\/*$CI_PROJECT_PATH.*;;")
    echo ${GITLAB_CREDENTIAL} >> ~/.git-credentials
    git config --global credential.helper store
}

setup_docker() {
    if [[ -n "$CI_JOB_TOKEN" && -n "$CI_REGISTRY" ]]; then
        docker login -u gitlab-ci-token -p ${CI_JOB_TOKEN} ${CI_REGISTRY} >/dev/null 2>/dev/null
    fi
}

setup_golang() {
    GITLAB_DOMAIN=$(echo $CI_REPOSITORY_URL | sed 's#^.*@##g;s#\/.*$##g')
    export GO_PROJECT_PATH=${GOPATH}/src/${GITLAB_DOMAIN}/${CI_PROJECT_PATH}
    mkdir -pv $(dirname $GO_PROJECT_PATH)
    setup_docker
}

setup_node() {
    npm config set unsafe-perm true
    if [[ -n "$NPM_TOKEN" ]]; then
        npm config set //npm.corp.hetao101.com/:_authToken "$NPM_TOKEN"
        npm config set registry https://npm.corp.hetao101.com
    fi
    setup_docker
}

setup_node_stretch() {
    npm config set unsafe-perm true
    if [[ -n "$NPM_TOKEN" ]]; then
        npm config set //npm.corp.hetao101.com/:_authToken "$NPM_TOKEN"
        npm config set registry https://npm.corp.hetao101.com
    fi
    setup_docker
}

setup_kube() {
    :
}

setup_swift() {
    :
}

setup_maven() {
    :
}

setup_autoops() {
    :
}

setup_common
setup_$HTCI_IMAGE_TYPE

exec "$@"