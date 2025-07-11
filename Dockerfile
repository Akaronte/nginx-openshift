# FROM centos:7.9.2009
# RUN yum install -y epel-release
# RUN yum install -y certbot python2-certbot-nginx unzip

# RUN echo -e '\
# [nginx-stable]\n\
# name=nginx stable repo\n\
# baseurl=http://nginx.org/packages/centos/7/x86_64/\n\
# gpgcheck=1\n\
# enabled=1\n\
# gpgkey=https://nginx.org/keys/nginx_signing.key\n\
# module_hotfixes=true\
# ' > /etc/yum.repos.d/nginx.repo

# RUN yum update -y

# RUN yum install -y nginx-1.22.0-1.el7.ngx.x86_64


# FROM nginx:1.23.1

# ADD https://github.com/open-telemetry/opentelemetry-cpp-contrib/releases/download/webserver%2Fv1.0.3/opentelemetry-webserver-sdk-x64-linux.tgz /opt
# RUN cd /opt ; unzip opentelemetry-webserver-sdk-x64-linux.tgz.zip; tar xvfz opentelemetry-webserver-sdk-x64-linux.tgz
# RUN cd /opt/opentelemetry-webserver-sdk; ./install.sh
# ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/opentelemetry-webserver-sdk/sdk_lib/lib

# RUN echo "load_module /opt/opentelemetry-webserver-sdk/WebServerModule/Nginx/1.23.1/ngx_http_opentelemetry_module.so;\n$(cat /etc/nginx/nginx.conf)" > /etc/nginx/nginx.conf


FROM ubuntu:22.04
### CERTBOT && NGINX
RUN apt-get update && apt-get install -y software-properties-common && echo "Europe/Madrid" > /etc/timezone
RUN apt-get install -y python3-dev python3-venv gcc libaugeas0 libssl-dev libffi-dev ca-certificates openssl
RUN apt-get install -y certbot sudo curl

RUN sudo apt install -y curl gnupg2 ca-certificates lsb-release ubuntu-keyring
# RUN curl -fsSL https://nginx.org/keys/nginx_signing.key | sudo gpg --dearmor -o /usr/share/keyrings/nginx-archive-keyring.gpg
# RUN echo "deb [signed-by=/usr/share/keyrings/nginx-archive-keyring.gpg] http://nginx.org/packages/ubuntu jammy nginx" | sudo tee /etc/apt/sources.list.d/nginx.list
# RUN sudo apt update
# RUN sudo apt install nginx -y
# RUN apt-get install -y unzip



ENV DEBIAN_FRONTEND=noninteractive
RUN apt update && apt install -y curl gnupg2 ca-certificates lsb-release apt-transport-https
RUN curl -fsSL https://nginx.org/keys/nginx_signing.key | apt-key add -
RUN echo "deb http://nginx.org/packages/ubuntu `lsb_release -cs` nginx" > /etc/apt/sources.list.d/nginx.list
RUN apt update && apt install -y nginx=1.22.0-1~`lsb_release -cs`
RUN echo "nginx hold" | dpkg --set-selections




ADD https://github.com/open-telemetry/opentelemetry-cpp-contrib/releases/download/webserver%2Fv1.0.3/opentelemetry-webserver-sdk-x64-linux.tgz /opt
RUN cd /opt ; unzip opentelemetry-webserver-sdk-x64-linux.tgz.zip; tar xvfz opentelemetry-webserver-sdk-x64-linux.tgz
RUN cd /opt/opentelemetry-webserver-sdk; ./install.sh
ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/opentelemetry-webserver-sdk/sdk_lib/lib



RUN chown nginx:nginx /var/log/nginx -R && \
    chown nginx:nginx /opt -R && \
    chgrp -R 0 /opt && \
    chmod -R g+rwX /opt && \
    chgrp -R 0 /var/log/nginx && \
    chmod -R g+rwX /var/log/nginx && \
    chown nginx:nginx /run -R && \
    chgrp -R 0 /run && \
    chmod -R g+rwX /run && \
    usermod -a -G root nginx


RUN chgrp -R root /var/cache/nginx /var/run /var/log/nginx && \
    chmod -R 770 /var/cache/nginx /var/run /var/log/nginx

# ENV PATH="${PATH}:/usr/sbin/nginx"

# USER nginx

CMD ["nginx", "-g", "daemon off;"]
