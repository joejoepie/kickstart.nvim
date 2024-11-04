#!/usr/bin/bash

folder=$1
cd $1
git clone https://github.com/microsoft/java-debug
cd java-debug
./mvnw clean install
