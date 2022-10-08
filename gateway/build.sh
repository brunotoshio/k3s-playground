#!/usr/bin/env bash

docker build -t toskube:32000/gateway .

TAG=$(git rev-parse HEAD)

docker tag $TAG toskube:32000/gateway

docker push toskube:32000/gateway
