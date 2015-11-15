#!/bin/bash

if [ -d "/home/vagrant/provision" ]; then
    rm -rf /home/vagrant/provision/
fi

if [ -d "/home/vagrant/templates" ]; then
    rm -rf /home/vagrant/templates/
fi
