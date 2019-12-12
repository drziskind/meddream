FROM php:7.1-apache
RUN apt-get update \
	&& apt-get install -y unzip vim net-tools ffmpeg less iputils-ping \
	&& rm -rf /var/lib/apt/lists/*
RUN mkdir -p /jre8 /opt/meddream /archive /usr/lib64/php/modules /usr/lib/php/modules
COPY MedDreamViewer-7.1.1.zip /
COPY jre-8u231-linux-x64.tar.gz /
COPY startCore.sh /
COPY start.sh /
RUN unzip /MedDreamViewer-7.1.1.zip -d / && rm /MedDreamViewer-7.1.1.zip
RUN tar xvzf /jre-8u231-linux-x64.tar.gz -C /jre8 && rm /jre-8u231-linux-x64.tar.gz
RUN cp -R /MedDreamViewer-7.1.1/MedDreamViewer/services /opt/meddream/services
COPY application.properties /opt/meddream/services/
ENV JAVA_HOME=/jre8/jre1.8.0_231
ENV PATH="${JAVA_HOME}/bin:${PATH}"
EXPOSE 8080
RUN chown www-data:www-data /opt/meddream/services
RUN find /opt/meddream/services -type d -exec chmod 775 {} \;
RUN find /opt/meddream/services -type f -exec chmod 664 {} \;


#apache
RUN cp -R /MedDreamViewer-7.1.1/MedDreamViewer/meddream /var/www/html/
COPY config.php /var/www/html/meddream/
RUN mv /etc/apache2/mods-available/deflate.* /etc/apache2/mods-enabled/ \
	&& mv /etc/apache2/mods-available/filter.* /etc/apache2/mods-enabled/ \	
        && mv /etc/apache2/mods-available/rewrite.* /etc/apache2/mods-enabled/ \
	&& mv /etc/apache2/mods-available/proxy.* /etc/apache2/mods-enabled/ \ 
	&& mv /etc/apache2/mods-available/proxy_http.* /etc/apache2/mods-enabled/ \ 
	&& mv /etc/apache2/mods-available/proxy_wstunnel.* /etc/apache2/mods-enabled/
RUN cp /var/www/html/meddream/php7.1_meddream-x86_64.so /usr/local/lib/php/extensions/no-debug-non-zts-20160303
RUN cp /usr/local/etc/php/php.ini-production /usr/local/etc/php/php.ini
RUN echo "extension=php7.1_meddream-x86_64.so" >> /usr/local/etc/php/php.ini
RUN chown www-data:www-data -R /var/www/html/meddream
RUN find /var/www/html/meddream -type d -exec chmod 775 {} \;	
RUN find /var/www/html/meddream -type f -exec chmod 664 {} \;	
RUN find /var/www/html/meddream -iname "*.sh" -exec chmod 775 {} \;	
COPY apache /
RUN cat /apache >> /etc/apache2/apache2.conf
RUN rm -rf /MedDreamViewer-7.1.1/ && rm -rf /opt/meddream/services/jre1.8.0_202
CMD ["/start.sh"]
