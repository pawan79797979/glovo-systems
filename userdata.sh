#!/bin/bash

sudo yum install -y java-1.8.0-openjdk
sudo yum install -y wget
sudo iptables -F
sudo mkdir /tmp/test-user-data
cd /opt
sudo wget https://s3-eu-west-1.amazonaws.com/glovo-public/systems-engineer-interview-1.0-SNAPSHOT.jar
sudo sleep 30
sudo touch glovo_server_logs
sudo chmod 777 glovo_server_logs
sudo nohup java -jar systems-engineer-interview-1.0-SNAPSHOT.jar server > glovo_server_logs 2>&1 &

