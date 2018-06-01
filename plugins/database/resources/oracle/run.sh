#!/bin/bash
set -e

docker run --rm --name oracle -p 1521:1521 wnameless/oracle-xe-11g