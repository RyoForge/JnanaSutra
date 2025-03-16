# Use official PHP 7.4 Apache image (Compatible with openSIS)
FROM php:7.4-apache

# Install required PHP extensions and dependencies
RUN apt-get update && apt-get install -y \
    libzip-dev \
    && docker-php-ext-install mysqli pdo pdo_mysql zip

# Enable Apache mod_rewrite
RUN a2enmod rewrite

# Set working directory
WORKDIR /var/www/html

# Copy project files to container
COPY . /var/www/html

# Set file permissions
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

# Set up Apache config (optional)
COPY ./docker/apache-config.conf /etc/apache2/sites-available/000-default.conf

# Expose Apache port
EXPOSE 80

# Start Apache service
CMD ["apache2-foreground"]