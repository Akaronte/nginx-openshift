FROM ubuntu:22.04
### CERTBOT && NGINX
RUN apt-get update && apt-get install -y software-properties-common && echo "Europe/Madrid" > /etc/timezone
RUN apt-get install -y python3-dev python3-venv gcc libaugeas0 libssl-dev libffi-dev ca-certificates openssl
RUN apt-get install -y certbot nginx


RUN ln -sf /dev/stdout /var/log/nginx/access.log
RUN ln -sf /dev/stderr /var/log/nginx/error.log

CMD ["nginx", "-g", "daemon off;"]
