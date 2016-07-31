#!/bin/bash

/usr/local/bin/docker-compose stop && /usr/local/bin/docker-compose rm --all -f && /usr/local/bin/docker-compose up -d
docker compose of www.altercoding.com
mono:
 image: altercoding
 environment:
  - VIRTUAL_HOST=www.altercoding.com
 expose:
  - "80"
 dns:
  - 8.8.8.8
  - 9.9.9.9
 restart: always
docker-compose of publish.altercoding.com
mono:
 build: ./GitHubPublisher/
 expose:
  - "80"
 volumes:
  - /var/run/docker.sock:/var/run/docker.sock
  - /usr/bin/docker-restart:/usr/bin/docker-restart
  - /usr/local/bin/docker-compose:/usr/local/bin/docker-compose
  - ../www.altercoding.com:/var/app/www.altercoding.com
 privileged: true
 environment:
  - VIRTUAL_HOST=publish.altercoding.com
  - altercoding_REPOSITORY_URL=https://github.com/HackYourJob/altercoding.git
  - altercoding_DEPLOY_SECRET=toto
 dns:
  - 8.8.8.8
  - 9.9.9.9
 restart: always