# -*- coding: utf-8 -*-
# vim: ft=yaml
#
# Set default values.
---
caddy:
  version: '2.5.1'
  rootgroup: root
  user: caddy
  group: caddy
  pkg:
    name: caddy
  config:
    dir: /etc/caddy
    file: Caddyfile
    validate: true
    format: true
    global_options:
      - email: webmaster@example.net
      - auto_https: 'off'
      - log main:
        - level: WARN
        - output: file /var/log/caddy/caddy-general.log
  service:
    name: caddy
  xcaddy: {}
  servers:
    - localhost:
      - root: '* /usr/share/caddy'
      - log:
        - level: WARN
        - output: file /var/log/caddy/localhost.log
    - 'example.com:80':
        - redir: 'https://example.net'
    - example.net:
      - 'handle_path /*':
          - root: '* /var/www/example.net/'
          - file_server
      - log:
        - level: WARN
        - output: file /var/log/caddy/example.net.log
