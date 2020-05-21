# Woo Solo Api wp-browser testing action

Github action for running wp-browser tests for woo-solo-api plugin

## Inputs

### `wp-db-name`

**Required** Name of the WordPress database. Default `'wordpresstest'`.

### `wp-db-user`

**Required** Name of the database user. Default `'admin'`.

### `wp-db-pass`

**Required** Name of the database password. Default `'password'`.

### `wp-user`

**Required** Name of the WordPress user. Default `'admin'`.

### `wp-pass`

**Required** Name of the WordPress password. Default `'password'`.

## Example usage

```yml
tests:
    name: Integration tests on PHP ${{ matrix.php }}
    runs-on: ubuntu-latest

    strategy:
        fail-fast: false
        matrix:
            php: [7.2]
            node: [14]
            wp: [5.1, 5.2, 5.3, 5.4]

    services:
        mysql:
            image: mysql:5.7
            env:
                MYSQL_ALLOW_EMPTY_PASSWORD: yes
                MYSQL_DATABASE: wordpresstest
                MYSQL_USER: admin
                MYSQL_PASSWORD: password
            ports:
                - 3306
            options: --health-cmd="mysqladmin ping" --health-interval=10s --health-timeout=5s --health-retries=3

    steps:
        - name: Checkout
          uses: actions/checkout@v2

        - name: Run tests WP${{ matrix.wp }} PHP${{ matrix.php }} Node${{ matrix.node }}
          uses: dingo-d/woo-solo-api-test-action/WP${{ matrix.wp }}-PHP${{ matrix.php }}-Node-${{ matrix.node }}@v1.0.28
          with:
            wp-db-name: 'wordpresstest'
            wp-db-user: 'admin'
            wp-db-pass: 'password'
            wp-db-host: 'mysql'
            wp-user: 'admin'
            wp-pass: 'password'
```
