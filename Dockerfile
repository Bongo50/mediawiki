FROM mediawiki:1.43

# Luxuries
RUN apt-get update && apt-get install -y \
        vim \
        less \
        zip \
        unzip \
        git \
        libmemcached-dev \
        libz-dev \
    --no-install-recommends && \
    rm -r /var/lib/apt/lists/*

RUN curl -sS https://getcomposer.org/installer | \
    php -- --install-dir=/usr/bin/ --filename=composer

# We want Apache's rewrite module
RUN a2enmod rewrite
RUN a2enmod headers

# MediaWiki needs these extra extensions
#RUN pecl install memcached && \
#    docker-php-ext-enable memcached

# We want the wiki in a w/ subfolder
RUN mv /var/www/html /var/www/i-will-be-w && \
    mkdir -p /var/www/html && \
    mv /var/www/i-will-be-w /var/www/html/w

# Assets
#COPY src/fonts /var/www/html/fonts
#COPY src/favicon.ico /var/www/html/

# Shell utils
COPY src/shell /var/www/html/shell

# MediaWiki extensions
WORKDIR /var/www/html/w/extensions
RUN git clone --depth 1 -b REL1_43 https://gerrit.wikimedia.org/r/mediawiki/extensions/TemplateStyles

#RUN composer install --no-dev --working-dir=/var/www/html/w/extensions/Echo

# Better Scribunto (lua) performance, apparently
# COPY ext/luasandbox /opt/luasandbox
# RUN apt-get update && apt-get install -y liblua5.1-0-dev
# RUN ( \
#     cd /opt/luasandbox; \
#     phpize; \
#     ./configure; \
#     make; \
#     make install \
# )
# RUN docker-php-ext-enable luasandbox

# Generate config at runtime
#COPY scripts/configure-mediawiki.sh /usr/local/bin/configure-mediawiki
#RUN chmod +x /usr/local/bin/configure-*

# Config templates
COPY configs/php.ini /usr/local/etc/php/php.ini
COPY configs/apache.conf /etc/apache2/sites-available/000-default.conf
COPY configs/LocalSettings.php /var/www/html/w/LocalSettings.php

# Any well known gubbins
#COPY src/.well-known /var/www/html/.well-known

VOLUME /var/www/html/w/images

# Required environmental variables
ENV DB_DATABASE='wiki'
ENV DB_HOST='db'
ENV DB_TYPE='mysql'
ENV DB_USER='root'
ENV RECAPTCHA_KEY=
ENV RECAPTCHA_SECRET=
ENV SECRET_KEY=
ENV SERVER_URL='https://mediawiki.localhost'
ENV SITENAME='Bongo50 Testing Wiki'

# Optional environmental variables
ENV DB_PASSWORD=
ENV EMAIL_EMERGENCY_CONTACT=
ENV EMAIL_PASSWORD_SENDER=
ENV MEMCACHED_HOST=
ENV READ_ONLY_MESSAGE=
ENV SMTP_AUTH=
ENV SMTP_HOST=
ENV SMTP_IDHOST=
ENV SMTP_PASSWORD=
ENV SMTP_PORT=
ENV SMTP_USERNAME=

#CMD /usr/local/bin/configure-mediawiki && apache2-foreground
CMD apache2-foreground
