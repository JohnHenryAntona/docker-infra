#!/bin/bash

##
## CRON DOCKER CONTAINER HEALTH CHECK
##
## This will only see if the process using the docker for each contaienr and try
## to revive them. Not all revival method will be a success unless otherwise
## known and stated here
##

##
## First check if docker service is running
##
docker_stat=$(service docker status | grep dead)
if [ -z "$docker_stat" ]
then
    echo "DOCKER SERVICE is not dead"
else
    echo "DOCKER SERVICE is DEAD\n"
    echo "Starting docker\n"
    service docker start
fi

##
## CHECK NGINX PROPXY
##
nginx_stat=$(docker ps | grep nginx-proxy)
if [ -z "$nginx_stat" ]
then
    echo "NGINX PROXY is DEAD, bringing it up now...."
    docker-compose -f /var/www/ideaxapps-infrastructure/proxy-tier/docker-compose.yml up -d
else
    echo "NGINX PROXY is healthy"
fi

##
## CHECK PORTAINER
##
portainer_stat=$(docker ps | grep portainer)
if [ -z "$portainer_stat" ]
then
    echo "PORTAINER is DEAD, bringing it up now...."
    docker-compose -f /var/www/ideaxapps-infrastructure/portainer/docker-compose.yml up -d
else
    echo "PORTAINER is healthy"
fi

##
## CHECK LIVE API
##
live_api_stat=$(docker ps | grep live-app-api)
if [ -z "$live_api_stat" ]
then
    echo "LIVE API is DEAD, bringing it up now...."
    docker-compose \
    -f /var/www/ideaxapps-infrastructure/project-tier-live/docker-compose.yml \
    up -d app-api
else
    echo "LIVE API is healthy"
fi

##
## CHECK LIVE web
##
live_web_stat=$(docker ps | grep live-app-web)
if [ -z "$live_web_stat" ]
then
    echo "LIVE WEB is DEAD, bringing it up now...."
    docker-compose \
    -f /var/www/ideaxapps-infrastructure/project-tier-live/docker-compose.yml \
    up -d app-web
else
    echo "LIVE WEB is healthy"
fi

##
## CHECK LIVE mongodb
##
live_mongodb_stat=$(docker ps | grep live-app-mongodb)
if [ -z "$live_mongodb_stat" ]
then
    echo "LIVE MONGODB is DEAD, bringing it up now...."
    docker-compose \
    -f /var/www/ideaxapps-infrastructure/project-tier-live/docker-compose.yml \
    up -d app-mongodb
else
    echo "LIVE MONGODB is healthy"
fi


##
## CHECK STAGING API
##
staging_api_stat=$(docker ps | grep staging-app-api)
if [ -z "$staging_api_stat" ]
then
    echo "STAGING API is DEAD, bringing it up now...."
    docker-compose \
    -f /var/www/ideaxapps-infrastructure/project-tier-staging/docker-compose.yml \
    up -d app-api
else
    echo "STAGING API is healthy"
fi

##
## CHECK STAGING WEB
##
staging_web_stat=$(docker ps | grep staging-app-web)
if [ -z "$staging_web_stat" ]
then
    echo "STAGING WEB is DEAD, bringing it up now...."
    docker-compose \
    -f /var/www/ideaxapps-infrastructure/project-tier-staging/docker-compose.yml \
    up -d app-web
else
    echo "STAGING WEB is healthy"
fi

##
## CHECK STAGING mongodb
##
staging_mongodb_stat=$(docker ps | grep staging-app-mongodb)
if [ -z "$staging_mongodb_stat" ]
then
    echo "STAGING MONGODB is DEAD, bringing it up now...."
    docker-compose \
    -f /var/www/ideaxapps-infrastructure/project-tier-staging/docker-compose.yml \
    up -d app-mongodb
else
    echo "STAGING MONGODB is healthy"
fi

##
## CHECK UAT API
##
uat_api_stat=$(docker ps | grep uat-app-api)
if [ -z "$uat_api_stat" ]
then
    echo "UAT API is DEAD, bringing it up now...."
    docker-compose \
    -f /var/www/ideaxapps-infrastructure/project-tier-uat/docker-compose.yml \
    up -d app-api
else
    echo "UAT API is healthy"
fi

##
## CHECK UAT WEB
##
uat_web_stat=$(docker ps | grep uat-app-web)
if [ -z "$uat_web_stat" ]
then
    echo "UAT WEB is DEAD, bringing it up now...."
    docker-compose \
    -f /var/www/ideaxapps-infrastructure/project-tier-uat/docker-compose.yml \
    up -d app-web
else
    echo "UAT WEB is healthy"
fi

##
## CHECK UAT mongodb
##
uat_mongodb_stat=$(docker ps | grep uat-app-mongodb)
if [ -z "$uat_mongodb_stat" ]
then
    echo "STAUATGING MONGODB is DEAD, bringing it up now...."
    docker-compose \
    -f /var/www/ideaxapps-infrastructure/project-tier-uat/docker-compose.yml \
    up -d app-mongodb
else
    echo "UAT MONGODB is healthy"
fi