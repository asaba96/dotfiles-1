#!/bin/bash

set -ex

sudo apt-get install software-properties-common -y
sudo apt-add-repository ppa:ansible/ansible -y
sudo apt-get update -q
sudo apt-get install ansible -y
