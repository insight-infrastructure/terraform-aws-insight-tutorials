SHELL := /bin/bash -euo pipefail

clear-cache:						## Clear the terragrunt and terraform caches
	@find . -type d -name ".terragrunt-cache" -prune -exec rm -rf {} \; && \
	find . -type d -name ".terraform" -prune -exec rm -rf {} \; && \
	find . -type f -name "*.tfstate*" -prune -exec rm -rf {} \;

