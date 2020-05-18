FROM wordpress:5.4.1-php7.2

RUN pecl install pcov \
  && docker-php-ext-enable pcov

RUN curl -sS https://getcomposer.org/installer | php \
  && chmod +x composer.phar && mv composer.phar /usr/local/bin/composer

RUN curl -sL https://deb.nodesource.com/setup_14.x | bash - \
  && apt-get install -yq nodejs build-essential

# Install requirements for wp-cli support
RUN apt-get update \
  && apt-get install -y sudo less mariadb-client \
  && rm -rf /var/lib/apt/lists/*

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
  && php wp-cli.phar --info \
  && chmod +x wp-cli.phar \
  && mv wp-cli.phar /usr/local/bin/wp

RUN npm install -g npm

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
