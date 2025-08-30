FROM mediawiki:1.43

# Luxuries
RUN apt-get update && apt-get install -y \
        vim \
        less \
        zip \
        unzip \
        git \
        python3 \
        ffmpeg \
        libvips \
        libvips-tools \
        ploticus \
        fonts-freefont-ttf \
        ghostscript imagemagick xpdf-utils \
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

# MediaWiki extensions
WORKDIR /var/www/html/w/extensions
RUN git clone --depth 1 -b REL1_43 https://gerrit.wikimedia.org/r/mediawiki/extensions/TemplateStyles && \
    git clone --depth 1 -b REL1_43 https://gerrit.wikimedia.org/r/mediawiki/extensions/CommonsMetadata && \
    git clone --depth 1 -b REL1_43 https://gerrit.wikimedia.org/r/mediawiki/extensions/Disambiguator && \
    git clone --depth 1 -b REL1_43 https://gerrit.wikimedia.org/r/mediawiki/extensions/WikiSEO && \
    git clone --depth 1 -b REL1_43 https://gerrit.wikimedia.org/r/mediawiki/extensions/Description2 && \
    git clone --depth 1 -b REL1_43 https://gerrit.wikimedia.org/r/mediawiki/extensions/Popups && \
    git clone --depth 1 -b REL1_43 https://gerrit.wikimedia.org/r/mediawiki/extensions/Variables && \
    git clone --depth 1 -b REL1_43 https://gerrit.wikimedia.org/r/mediawiki/extensions/TitleKey && \
    git clone --depth 1 -b REL1_43 https://gerrit.wikimedia.org/r/mediawiki/extensions/CodeMirror && \
    git clone --depth 1 -b REL1_43 https://gerrit.wikimedia.org/r/mediawiki/extensions/CharInsert && \
    git clone --depth 1 -b REL1_43 https://gerrit.wikimedia.org/r/mediawiki/extensions/TwoColConflict && \
    git clone --depth 1 -b REL1_43 https://gerrit.wikimedia.org/r/mediawiki/extensions/RandomSelection && \
    git clone --depth 1 -b REL1_43 https://gerrit.wikimedia.org/r/mediawiki/extensions/DismissableSiteNotice && \
    git clone --depth 1 -b REL1_43 https://gerrit.wikimedia.org/r/mediawiki/extensions/RSS && \
    git clone --depth 1 -b REL1_43 https://gerrit.wikimedia.org/r/mediawiki/extensions/TemplateWizard && \
    git clone --depth 1 -b REL1_43 https://gerrit.wikimedia.org/r/mediawiki/extensions/TemplateSandbox && \
    git clone --depth 1 -b REL1_43 https://gerrit.wikimedia.org/r/mediawiki/extensions/Loops && \
    git clone --depth 1 -b REL1_43 https://gerrit.wikimedia.org/r/mediawiki/extensions/CookieWarning && \
    git clone --depth 1 -b REL1_43 https://gerrit.wikimedia.org/r/mediawiki/extensions/timeline && \
    git clone --depth 1 -b REL1_43 https://gerrit.wikimedia.org/r/mediawiki/extensions/Cargo && \
    git clone --depth 1 -b REL1_43 https://github.com/wiki-gg-oss/mediawiki-extensions-ParserPower.git && mv mediawiki-extensions-ParserPower ParserPower && \
    git clone --depth 1 -b REL1_43 https://github.com/AlPha5130/mediawiki-extensions-EditCountNeue.git && mv mediawiki-extensions-EditCountNeue EditCountNeue && \
    git clone --depth 1 -b v3.4.3 https://github.com/StarCitizenWiki/mediawiki-extensions-EmbedVideo.git && mv mediawiki-extensions-EmbedVideo EmbedVideo && \
    git clone --depth 1 -b v1.0.0 https://github.com/StarCitizenTools/mediawiki-extensions-Thumbro.git && mv mediawiki-extensions-Thumbro Thumbro && \
    git clone --depth 1 -b 1.6.0 https://github.com/Liquipedia/VariablesLua.git && \
    git clone --depth 1 https://github.com/Universal-Omega/PortableInfobox.git

WORKDIR /var/www/html/w

RUN composer update
RUN COMPOSER=composer.local.json composer require --no-update mediawiki/maps:~10.1
RUN composer update mediawiki/maps --no-dev -o

RUN chmod a+x /var/www/html/w/extensions/SyntaxHighlight_GeSHi/pygments/pygmentize

WORKDIR /var/www/html/w/extensions/TemplateStyles
RUN composer install --no-dev

WORKDIR /var/www/html

# Config templates
COPY configs/php.ini /usr/local/etc/php/php.ini
COPY configs/apache.conf /etc/apache2/sites-available/000-default.conf
COPY configs/LocalSettings.php /var/www/html/w/LocalSettings.php

# Copy scripts
COPY scripts/startup.sh /home/startup.sh
COPY scripts/mwjobrunner /usr/local/bin/mwjobrunner

RUN chmod 755 /usr/local/bin/mwjobrunner

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

WORKDIR /var/www/html/w

CMD /home/startup.sh