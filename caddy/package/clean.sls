# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_config_clean = tplroot ~ '.config.clean' %}
{%- from tplroot ~ "/map.jinja" import mapdata as caddy with context %}

include:
  - {{ sls_config_clean }}

caddy-package-clean-pkg-removed:
  pkg.removed:
    - name: {{ caddy.pkg.name }}
    - require:
      - sls: {{ sls_config_clean }}
