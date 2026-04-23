FROM php:8.2-apache

RUN apt-get update && apt-get install -y \
    libpng-dev \
    libxml2-dev \
    libzip-dev \
    libbz2-dev \
    libldap2-dev \
    libexif-dev \
    libicu-dev \
    netcat-openbsd \
    && rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-install \
    mysqli \
    pdo_mysql \
    gd \
    exif \
    zip \
    bz2 \
    xml \
    intl \
    opcache \
    ldap

RUN echo "session.cookie_httponly = on" >> /usr/local/etc/php/conf.d/security.ini

RUN curl -fsSL https://github.com/glpi-project/glpi/releases/download/10.0.16/glpi-10.0.16.tgz \
    | tar -xz --strip-components=1 -C /var/www/html/

RUN mkdir -p /var/www/html/files /var/www/html/config \
    && chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

RUN a2enmod rewrite

RUN printf 'RewriteEngine On\nRewriteCond %%{REQUEST_FILENAME} !-f\nRewriteRule ^(.*)$ index.php [QSA,L]\n' > /var/www/html/public/.htaccess

COPY glpi-apache.conf /etc/apache2/sites-available/000-default.conf
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["apache2-foreground"]
