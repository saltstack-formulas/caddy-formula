# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as caddy with context %}

caddy-package-install-pkg-installed:
  {% if salt['grains.get']('os_family') == "Debian" %}
  pkg.installed:
    - name: {{ caddy.pkg.name }}
    - sources:
      - caddy: https://github.com/caddyserver/caddy/releases/download/v{{ caddy.version }}/caddy_{{ caddy.version }}_linux_{{ grains.osarch }}.deb
  {% endif %}

