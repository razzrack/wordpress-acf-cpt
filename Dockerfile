FROM wordpress:php8.3-apache

# Install PHP extensions
RUN apt-get update && apt-get install -y \
    less \
    libzip-dev \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    unzip \
    zip \
    default-mysql-client \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd zip

# Set default working directory for WP-CLI
WORKDIR /var/www/html

# Install WP-CLI
ADD https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar /usr/local/bin/wp
RUN chmod +x /usr/local/bin/wp

# Copy WordPress core directly from root of build context
COPY . /var/www/html/

# Copy custom PHP config
COPY upload.ini /usr/local/etc/php/conf.d/upload.ini

# Ensure wp-content has proper permissions
RUN mkdir -p /var/www/html/wp-content \
    && chown -R www-data:www-data /var/www/html/wp-content \
    && chmod -R 755 /var/www/html/wp-content

# Set timezone
ENV TZ=Asia/Jakarta

# Copy init script
COPY init.sh /usr/local/bin/init.sh
RUN chmod +x /usr/local/bin/init.sh

# Set entrypoint to run the init script
ENTRYPOINT ["/usr/local/bin/init.sh"]