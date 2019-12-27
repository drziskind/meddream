FROM alpine:3.7
#RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories

#bugfix
RUN mkdir /run/apache2 && chmod 660 /run/apache2

# Add basics first
RUN apk add --no-cache \
	apache2 php7-apache2 php7 php7-phar php7-json php7-iconv vim openjdk8-jre-base zip php7-session php7-xml php7-simplexml php7-curl apache2-proxy ffmpeg

#Add Local Files
COPY MedDreamViewer-7.1.1.zip /
COPY startCore.sh /
COPY start.sh /
COPY config.php /
COPY apache /
COPY application.properties /

#place Meddream
RUN unzip /MedDreamViewer-7.1.1.zip \
	&& rm /MedDreamViewer-7.1.1.zip \
	&& mkdir -p /opt/meddream /archive \
	&& cp -R /MedDreamViewer-7.1.1/MedDreamViewer/services /opt/meddream/ \
	&& cp -R /MedDreamViewer-7.1.1/MedDreamViewer/meddream /var/www/localhost/htdocs/ \
	&& mv /var/www/localhost/htdocs/meddream/php7.1_meddream-x86_64.so /usr/lib/php7/modules/ \
	&& mv /application.properties /opt/meddream/services \
	&& chmod 755 /usr/lib/php7/modules/php7.1_meddream-x86_64.so \
	&& mv /config.php /var/www/localhost/htdocs/meddream \
	&& chown apache:apache -R /var/www/localhost/htdocs/meddream \
	&& find /var/www/localhost/htdocs/meddream -type d -exec chmod 775 {} \; \
	&& find /var/www/localhost/htdocs/meddream -type f -exec chmod 664 {} \; \
	&& rm -rf /MedDreamViewer-7.1.1	
RUN sed -i "s/#LoadModule deflate_module/LoadModule deflate_module/" /etc/apache2/httpd.conf \
	&& sed -i "s/#LoadModule rewrite_module/LoadModule rewrite_module/" /etc/apache2/httpd.conf \
	&& sed -i '/LogFormat.*\bcombined/s/%h/%\{X-Forwarded-For\}i/' /etc/apache2/httpd.conf


RUN echo "extension=php7.1_meddream-x86_64.so" >> /etc/php7/php.ini
RUN cat apache >> /etc/apache2/httpd.conf
EXPOSE 8080
CMD ["/start.sh"]
