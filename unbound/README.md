unbound
=========

Deploy and manage [unound](https://unbound.net/index.html)

> Unbound is a validating, recursive, and caching DNS resolver.

Requirements
------------

TODO.

Role Variables
--------------

TODO.

Dependencies
------------

TODO.

Example Playbook
----------------

The following playbook would deliver an unbound server using dnscrypt-proxy
for most queries, and fordwarding to a local consul client for queries
to the consul domain.

```
- hosts:
    - dns_resolvers
  vars:
    consul_domain: testing
    unbound_forward_domains:
      - name: dnscrypt-proxy
       forward_domain: "."
       forward_addresses:
         - 127.0.0.1@53000
    unbound_stub_domains:
      - name: consul
       stub_domain: "{{ consul_domain }}"
       stub_addresses:
         - 127.0.0.1@8600
    unbound_insecure_domains:
      - "{{ consul_domain }}"
  roles:
    - consul
    - dnscrypt-proxy
    - unbound

```

License
-------

GPLv3.

Author Information
------------------

* https://gitlab.com/iwaseatenbyagrue
