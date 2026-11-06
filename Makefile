TF           ?= terraform
AWS          ?= aws
PLAN         ?= tfplan
DESTROY_PLAN ?= tfplan-destroy
SSH_USER     ?= ec2-user
SSH_OPTS     ?= -o StrictHostKeyChecking=accept-new -o IdentitiesOnly=yes -o ConnectTimeout=10

.PHONY: tf-init tf-plan tf-fmt tf-validate tf-apply tf-destroy tf-output ssh ssm-verify ssm-start

tf-init:
	$(TF) init

tf-fmt:
	$(TF) fmt -recursive

tf-validate:
	$(TF) validate

tf-plan:
	$(TF) plan

tf-planp:
	$(TF) plan -out=$(PLAN)

tf-applyp:
	@test -f $(PLAN) || { echo "No plan file '$(PLAN)'. Run 'make tf-plan' first."; exit 1; }
	$(TF) apply $(PLAN)

tf-apply:
	$(TF) apply -auto-approve

tf-destroy:
	$(TF) plan -destroy -out=$(DESTROY_PLAN)
	@printf "Apply this destroy plan? Type 'yes' to continue: "; \
	IFS= read -r ans; \
	if [ "$$ans" != "yes" ]; then echo "Aborted."; exit 1; fi
	$(TF) apply $(DESTROY_PLAN)

tf-output:
	$(TF) output

ssh:
	@ip="$$($(TF) output -raw public_ip)"; \
	key="$$($(TF) output -raw private_key_path)"; \
	ssh $(SSH_OPTS) -i "$$key" $(SSH_USER)@$$ip

ssm-verify:
	@ip="$$($(TF) output -raw public_ip)"; \
	id="$$($(TF) output -raw instance_id)"; \
	key="$$($(TF) output -raw private_key_path)"; \
	echo "=== Host SSM agent (via SSH) ==="; \
	ssh $(SSH_OPTS) -i "$$key" $(SSH_USER)@$$ip 'rpm -q amazon-ssm-agent; sudo systemctl status amazon-ssm-agent --no-pager'; \
	echo; \
	echo "=== AWS managed node status ==="; \
	$(AWS) ssm describe-instance-information \
		--filters "Key=InstanceIds,Values=$$id" \
		--query "InstanceInformationList[0].{InstanceId:InstanceId,PingStatus:PingStatus,AgentVersion:AgentVersion,LastPingDateTime:LastPingDateTime}" \
		--output table

ssm-start:
	@ip="$$($(TF) output -raw public_ip)"; \
	key="$$($(TF) output -raw private_key_path)"; \
	ssh $(SSH_OPTS) -i "$$key" $(SSH_USER)@$$ip 'sudo systemctl enable --now amazon-ssm-agent; sudo systemctl status amazon-ssm-agent --no-pager'
