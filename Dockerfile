FROM ubuntu AS web100
LABEL maintainer="Michal Koziara mkoziara12@gmail.com"
RUN apt-get update
RUN apt-get install -y apache2
RUN sed -i '/Listen 80/c\Listen 8080' /etc/apache2/ports.conf && service apache2 restart
CMD apachectl -D FOREGROUND
EXPOSE 8080
