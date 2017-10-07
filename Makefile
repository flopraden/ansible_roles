ROLES_DIR = $(shell pwd)
EXTRA_ARGS =
DOCKER_ARGS =
DOCKER_CONTAINER="centos"

.PHONY : test_all test_role test_role_with_artifact test_tagged
 

test_all: tag_container
	docker run --rm -ti -v $(ROLES_DIR):/etc/ansible/roles:ro $(DOCKER_ARGS) $(DOCKER_CONTAINER) find /etc/ansible/roles -path "*/tests/test.yml" -exec ansible-playbook -i /etc/ansible/hosts -D $(EXTRA_ARGS) {} \;

test_role:
	docker run --rm -ti -v $(ROLES_DIR):/etc/ansible/roles:ro  $(DOCKER_ARGS) $(DOCKER_CONTAINER) ansible-playbook -i /etc/ansible/hosts -D $(EXTRA_ARGS) /etc/ansible/roles/$(ROLE)/tests/test.yml

test_role_with_artifact:
	docker run -ti -v $(ROLES_DIR):/etc/ansible/roles:ro  $(DOCKER_ARGS) $(DOCKER_CONTAINER) ansible-playbook -i /etc/ansible/hosts -D $(EXTRA_ARGS) /etc/ansible/roles/$(ROLE)/tests/test.yml


test_tagged:
	docker run --rm -ti -v $(ROLES_DIR):/etc/ansible/roles:ro  $(DOCKER_ARGS) $(DOCKER_CONTAINER) find /etc/ansible/roles -path "*/tests/test.yml" -exec ansible-playbook -t $(TAG) -i /etc/ansible/hosts $(EXTRA_ARGS) -D {} \;
