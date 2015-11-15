#!/bin/bash
# Apache vhost creation

### Set default parameters
VAGRANT_URL=$1
VAGRANT_DIR=$2
API_URL=$3
API_DIR=$4

rm  /etc/apache2/sites-available/*
rm  /etc/apache2/sites-enabled/*

sudo virtualhost create ${VAGRANT_URL} ${VAGRANT_DIR}
sudo virtualhost create ${API_URL} ${API_DIR}

rm  /etc/nginx/sites-available/*
rm  /etc/nginx/sites-enabled/*

sudo virtualhost-nginx create ${VAGRANT_URL} ${VAGRANT_DIR}
sudo virtualhost-nginx create ${API_URL} ${API_DIR}
