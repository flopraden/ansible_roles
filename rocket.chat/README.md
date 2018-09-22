rocket.chat
===========

Install, configure, and perform simple API tasks for [rocketchat](https://rocket.chat/).

This role can also install the [rocketchat-specific version of hubot](https://rocket.chat/docs/bots/).

Example playbook
-----------------

To deploy a standalone rocketchat server running all required software:

```
- hosts:
    - rocketchat_servers
  roles:
    - cfssl
    # For CentOS, common pulls in EPEL.
    - common
    - docker
    - mongodb
    - nginx
    - rocket.chat
```

This would typically be used with the following content in
`group_vars/rocketchat_servers`:

```
rocketchat_root_url: https://my.rocketchat.domain
rocketchat_docker_publish: 3000:3000
# This URL just abuses the fact publishing the rocketchat port will make it
# available on the default docker bridge IP assigned to the host.
rocketchat_hubot_url: 172.17.0.1:3000
rocketchat_mongo_base_url: mongodb://172.17.0.1:27017

rocketchat_hubot_user: bot
rocketchat_hubot_name: bot

rocketchat_admin_user: admin
rocketchat_admin_password: admin

rocketchat_users:
  - username: "{{ rocketchat_hubot_user }}"
    name: "{{ rocketchat_hubot_name }}"
    password: "{{ rocketchat_hubot_password }}"
    email: "{{ rocketchat_hubot_user }}@{{ rocketchat_munged_url }}"
    roles:
      - bot
    joinDefaultChannels: false

mongodb_listen_address: 0.0.0.0
# This is required due to rocketchat using the mongo oplog.
mongodb_replicaset_initialise: true

# /!\ WARNING: Not suitable for production
rocketchat_validate_api_certs: false

rocketchat_channels:
  - name: general
    action: create

nginx_vhosts:
  - name: rocketchat
    upstream_port: 3000
    upstream_protocol: http
    upstream_group: rocketchat_servers
    hostname: "my.rocketchat.domain"                                      
    backend_config: |

        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";

        proxy_set_header Host $http_host;

        proxy_set_header X-Real-IP $remote_addr;

        proxy_set_header X-Forward-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forward-Proto http;
        proxy_set_header X-Nginx-Proxy true;

        proxy_redirect off;
```

License
-------

GPLv3
