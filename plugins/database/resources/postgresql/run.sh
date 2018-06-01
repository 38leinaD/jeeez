#!/bin/bash
set -e

docker run --rm --name postgres -p 5432:5432 postgres:9.5