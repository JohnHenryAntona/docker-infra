## DOCKER MULTITEER

# PORTAINER
You will run this once, as portainer listens to the global Docker
```
cd portainer
docker-compose up -d
```

# PROXY TIER
You will run this once, as the nginx proxy listens to the  global Docker
```
cd proxy-tier
docker-compose up -d
```

How to bind your domain with nginx proxy, just add these environments to the per service

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

Then is very important to use the proxy nginx external network for your services

```

networks:
  # define it in your project
  proxy-tier_nginx:
    external: true

services:
    ...
    # Then add the network to each service
    your-service-app:
      networks:
        - proxy-tier_nginx

```

# PROJECT TIER
Now this is a custom project scoped for your project, but the basic containers are included here to get you started

Cheers! :) 

For more information, reach out to John Henry Antona

