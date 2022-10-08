#!/usr/bin/env bash

docker build -t toskube:32000/gateway:latest .

TAG=$(docker images --filter=reference=toskube:32000/gateway:latest --format "{{.ID}}")

docker tag $TAG toskube:32000/gateway:latest

docker push toskube:32000/gateway:latest
