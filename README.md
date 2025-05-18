## DOCKER MULTIE TIER

# PORTAINER
You will rnu this once, as portainer listen to global docker
```
cd portainer
docker-compose up -d
```

# PROXY TIER
You will rnu this once, as nginx proxy listen to global docker
```
cd proxy-tier
docker-compose up -d
```

How to bind your domain with nginx proxy, just add these environments to per service

```
services:

    ...
    your-service-app:
      environment:
        - VIRTUAL_HOST=subdomain.domain.com
        - VIRTUAL_PORT=443 # Internal port of this service
        - VIRTUAL_PROTO=https
        ## Add this, this is translated as default.csr inside certs proxy-tier/nginx-proxy/certs
        - CERT_NAME=default 

```

Then very important is to use the proxy nginx external network for your services

```

networks:
  # define it in your project
  proxy-tier_nginx:
    external: true

services:
    ...
    # then add the network to each service
    your-service-app:
      networks:
        - proxy-tier_nginx

```

# PROJECT TIER
Now this is a custom project scoped for you project, but the basic containers are included hre to get you started

Cheers! :) 

For more information reach our to john henry antona and josel mariano

