FROM ubuntu:22.04
### CERTBOT && NGINX
RUN apt-get update && apt-get install -y software-properties-common && echo "Europe/Madrid" > /etc/timezone
RUN apt-get install -y python3-dev python3-venv gcc libaugeas0 libssl-dev libffi-dev ca-certificates openssl
RUN apt-get install -y certbot nginx

RUN mkdir -p /var/cache/nginx /var/run /var/log/nginx
RUN chgrp -R root /var/cache/nginx /var/run /var/log/nginx
RUN chmod -R 770 /var/cache/nginx /var/run /var/log/nginx

CMD ["nginx", "-g", "daemon off;"]
