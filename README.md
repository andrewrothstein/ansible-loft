andrewrothstein.loft
=========
![Build Status](https://github.com/andrewrothstein/ansible-loft/actions/workflows/build.yml/badge.svg)

Installs the [loft](https://loft.sh) CLI and devspaces plugin

Requirements
------------

See [meta/main.yml](meta/main.yml)

Role Variables
--------------

See [defaults/main.yml](defaults/main.yml)

Dependencies
------------

See [meta/main.yml](meta/main.yml)

Example Playbook
----------------

```yml
- hosts: servers
  roles:
    - andrewrothstein.loft
```

License
-------

MIT

Author Information
------------------

Andrew Rothstein <andrew.rothstein@gmail.com>
