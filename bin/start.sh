#! /bin/sh

set -e

jar=$(ls -1 /app/*.jar)

java -jar ${jar}
