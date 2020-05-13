# WordPress plugin testing action

Github action for running wp-browser tests for your plugin

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

uses: actions/plugin-test-action@v1
with:
  wp-db-name: 'wordpress-test'
  wp-db-user: 'root'
  wp-db-pass: 'rootpass'
  wp-user: 'admin'
  wp-pass: 'somepass'