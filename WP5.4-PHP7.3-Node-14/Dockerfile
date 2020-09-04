FROM wordpress:5.4.1-php7.3-apache

# Node.js from NodeSource
RUN set -ex \
    && curl -sL https://deb.nodesource.com/setup_14.x | APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=1 bash -

# Install OS packages
RUN set -ex \
  && apt-get install -y nodejs build-essential \
      sudo less mariadb-client \
  && rm -rf /var/lib/apt/lists/*

# Upgrade npm
RUN set -ex \
  && npm install -g npm@latest \
  && npm version

# Install pcov PHP extension for fast code coverage generation
RUN set -ex \
  && yes "" | pecl install pcov \
  && docker-php-ext-enable pcov \
  && php --ri pcov

# Composer setup
RUN set -ex \
  && EXPECTED_SIGNATURE="$(curl -sL https://composer.github.io/installer.sig)" \
  && php -r 'copy("https://getcomposer.org/installer", "composer-setup.php");' \
  && ACTUAL_SIGNATURE="$(php -r 'echo hash_file("sha384", "composer-setup.php");')" \
  && test "$EXPECTED_SIGNATURE" = "$ACTUAL_SIGNATURE" \
  && php composer-setup.php --install-dir /usr/local/bin --filename composer \
  && rm composer-setup.php \
  && composer --version

# Install WP-CLI
RUN set -ex \
  && curl -sO https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
  && install --verbose --mode=0755 --no-target-directory wp-cli.phar /usr/local/bin/wp \
  && wp --info

COPY entrypoint.sh /entrypoint.sh

WORKDIR /usr/src/wordpress

ENTRYPOINT ["/entrypoint.sh"]
