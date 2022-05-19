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
    global_options:
      - email: webmaster@example.net
      - auto_https: 'off'
      - log main:
        - level: WARN
        - output: file /var/log/caddy/caddy-general.log
  service:
    name: caddy
  servers:
    - localhost:
      - root: '* /usr/share/caddy'
      - log:
        - level: WARN
        - output: file /var/log/caddy/localhost.log
    - 'example.com:80':
        - redir: 'https://example.net'
    - example.net:
      - encode: gzip
      - 'handle_path /*':
          - root: '* /var/www/example.net/'
          - file_server
      - log:
        - level: WARN
        - output: file /var/log/caddy/example.net.log
    - multi.level.example.net:
      - encode: gzip
      - 'route /path/*':
        - 'basicauth *':
          - user: JDJhJDE0JFJxLjBBTXhVTHF2VHBoVU54LjFXQnVEQkZYdFhlVmUzSmxRL3VrQVcwS05IQnVIS2FBREIy
        - root: '* /var/www/html/'
        - try_files: '{path} /path/to/index.cgi'
        - '@cgi': 'path *.cgi'
        - handle /path/to/index.cgi:
          - reverse_proxy @cgi unix//run/fcgiwrap.socket:
            - transport fastcgi:
              - resolve_root_symlink
              - split: .cgi
        - file_server
      - log:
        - level: WARN
        - output: file /var/log/caddy/multi.level.example.net.log
