FROM wordpress:5.4.1-php7.2

RUN apt-get update \
  && apt-get install -y sudo less mariadb-client \
  && rm -rf /var/lib/apt/lists/*

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
  && php wp-cli.phar --info \
  && chmod +x wp-cli.phar \
  && mv wp-cli.phar /usr/local/bin/wp

COPY entrypoint.sh /entrypoint.sh

WORKDIR /usr/src/wordpress

ENTRYPOINT ["/entrypoint.sh"]
