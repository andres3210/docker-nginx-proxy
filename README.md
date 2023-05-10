## Nginx Proxy Installation

```bash
# Step 1 - Init docker network
sh init.sh

# Step 2 - Spin docker contaienrs
docker compose up -d
```



## How to add annotations to autodetect a new app

Add the following lines to the docker-compose.yaml to the container that is meant to expose to http(s) traffic.

```yaml
version: '3'

services:
  example_app:
    environment:
      # mandatory annotation to define host or hosts (comma separated)
      - VIRTUAL_HOST=${APP_HOST}
      # mandatory annotation to define listening port
      - VIRTUAL_PORT=80
      # Optional interal protocol. Options: http (default), https, fastcgi, uwsgi
      - VIRTUAL_PROTO=http
      # optional annotation for ssl-redirect. Options: redirect (default), noredirect, nohttps
      - HTTPS_METHOD=noredirect
      # optional annotation for freessl certificate generation of host or hosts (comma separated)
      - LETSENCRYPT_HOST=${APP_HOST}
    networks:
      - reverse-proxy

networks:
  # Mandatory netork for internal host detection
  reverse-proxy:
    external: true
```



## How to install a SSL Certificate 

```bash
# Add certificate files in the docker-nginx-proxy shared volume
# Domain may be a wildcard by naming the file *.domain.com...
../nginx/certs/example.domain.com.crt
../nginx/certs/example.domain.com.key
```



### How to add specific Nginx config to a vhost

```bash
# Create a config file with the vhost domain name
../vhost.d/example.domain.com

# Example file contents (the file will be injected inside of the vhost server definition
client_max_body_size 20M;
```

