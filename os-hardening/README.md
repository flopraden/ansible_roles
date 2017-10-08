Role Name
=========

The os-hardening role primarily aims to provide compliance with security and auditing best practice.
It also aims to provide compliance with standards such as PCI-DSS and RedHat Certified Cloud Provider openSCAP profiles.

Currently, this role provides 90%+ compliance with:

* PCI-DSS
* RHT-CCP

Compliance was measured for a centos 7 container to which the role was run with default settings.

Where appropriate, defaults for this and related roles tend towards the more restrictive requirements.
For example, password quality rules are in line with DISA/DoD standards, rather than 'only' PCI-DSS.

Requirements
------------

Any pre-requisites that may not be covered by Ansible itself or the role should be mentioned here. For instance, if the role uses the EC2 module, it may be a good idea to mention in this section that the boto package is required.

Role Variables
--------------

A description of the settable variables for this role should go here, including any variables that are in defaults/main.yml, vars/main.yml, and any variables that can/should be set via parameters to the role. Any variables that are read from other roles and/or the global scope (ie. hostvars, group vars, etc.) should be mentioned here as well.

Dependencies
------------

A list of other roles hosted on Galaxy should go here, plus any details in regards to parameters that may need to be set for other roles, or variables that are used from other roles.

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: servers
      roles:
         - { role: username.rolename, x: 42 }

License
-------

BSD

Author Information
------------------

An optional section for the role authors to include contact information, or a website (HTML is not allowed).
