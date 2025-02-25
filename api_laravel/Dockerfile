FROM php:8.3.11-fpm

# Set working directory
WORKDIR /var/www

# Update package list and install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    libpng-dev \
    libjpeg-dev \
    libwebp-dev \
    libxpm-dev \
    libfreetype6-dev \
    libzip-dev \
    zip \
    unzip \
    git \
    bash \
    fcgiwrap \
    libmcrypt-dev \
    libonig-dev \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# Install PHP extensions
RUN docker-php-ext-configure gd --with-freetype --with-jpeg --with-webp \
    && docker-php-ext-install gd \
    && docker-php-ext-install pdo pdo_pgsql mbstring zip exif pcntl bcmath opcache

# Install Composer
COPY --from=composer/composer:latest-bin /composer /usr/bin/composer

# Copy composer.json and composer.lock
COPY composer.json composer.lock ./

# Install PHP dependencies
RUN composer install --no-scripts --no-autoloader

# Copy existing application directory contents
COPY . /var/www

# Copy existing application directory permissions
COPY --chown=www-data:www-data . /var/www

# Copy .env file
# COPY .env /var/www/.env

# Generate optimized autoload files
RUN composer dump-autoload --optimize

# Set ownership and permissions for the /var/www directory to www-data
RUN chown -R www-data:www-data /var/www

# Expose port 8000 and start php-fpm server
EXPOSE 8000
CMD ["php", "artisan", "serve", "--host=0.0.0.0"]