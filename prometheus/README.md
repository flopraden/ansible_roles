prometheus
======

The prometheus role installs and configures a [prometheus](https://prometheus.io/) server.

It also configures some static, file-based targets based on provided config.

When installed directly on a host, multiple versions can be installed.
The specified version will be linked to to /opt/prometheus/current.

Requirements
-------------

When installing directly on a host, this role simply requires internet access.
This is needed to download release binaries.

For dockerised installs, docker is required.

Role Variables
---------------

See defaults/main.yml for a full list.

The more useful variables are:

### prometheus_version

The version of prometheus to run.

### prometheus_blackbox_address

The address of the default blackbox exporter to use.

### prometheus_scrape_configs

Allows configuring scrape details for a given scrape type in prometheus.yml.

The scrape type should match a type value for an entry in
prometheus_scrape_targets to be used.

This is typically used for configuring blackbox exporters, as in:

```
prometheus_scrape_configs:
  blackbox_exporter:
    metrics_path: /probe
    params:
      module: [http_2xx]  # Look for a HTTP 200 response.
    relabel_configs:
      - source_labels: [__address__]
        target_label: __param_target
      - source_labels: [__param_target]
        target_label: instance
      - target_label: __address__
        replacement: "{{ prometheus_blackbox_address }}"
```

### prometheus_scrape_targets

Allows configuring scrapes in prometheus.yml.

A simple example would be:

```
prometheus_scrape_targets:
  - name: grafana
    type: grafana
    port: 3000
    groups:
      - grafana
  - name: internal_sites
    type: blackbox_exporter
	targets:
      - https://my.site.tld
      - https://my.site.tld/users/
      - https://the.site.tld
```

For the grafana entry, groups should match an ansible inventory group, from
which target hosts will be extracted.

For the internal_sites entry, the type will match the prometheus_scrape_config
above, and will use the blackbox exporter defined in it.

Dependencies
------------

TODO

Example Playbook
----------------

```
- hosts: prometheus_servers
  roles:
	- prometheus
  vars:
    prometheus_scrape_configs:
	  authenticated_blackbox:
	    metrics_path: /probe
	    params:
	      module: [http_2xx]  # Look for a HTTP 200 response.
	    relabel_configs:
	      - source_labels: [__address__]
		    target_label: __param_target
	      - source_labels: [__param_target]
		    target_label: instance
	      - target_label: __address__
		    replacement: "somehost:9100"
    prometheus_scrape_targets:
	  - name: grafana
		type: grafana
		port: 3000
		groups:
		  - grafana
	  - name: web_servers
		type: node_exporter
		port: 9091
		groups:
		  - grafana
	  - name: internal_sites
		type: authenticated_blackbox
		targets:
		  - https://my.site.tld
		  - https://my.site.tld/users/
		  - https://the.site.tld

```


License
-------

GPLv3

