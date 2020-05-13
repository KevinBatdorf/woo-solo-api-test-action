FROM wordpress:5.4.1-php7.2

RUN pecl install pcov \
  && docker-php-ext-enable pcov

RUN curl -sS https://getcomposer.org/installer | php \
  && chmod +x composer.phar && mv composer.phar /usr/local/bin/composer

RUN curl -sL https://deb.nodesource.com/setup_14.x | bash - \
  && apt-get install -yq nodejs build-essential

RUN npm install -g npm

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
