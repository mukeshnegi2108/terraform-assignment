# ==============================================================================
# TERRAFORM MAKEFILE
# ==============================================================================

.PHONY: help init plan apply destroy fmt validate lint clean docs

# Default environment
ENV ?= dev
REGION ?= us-east-1
APP_DIR = applications/application1
CONFIG_DIR = config/us/$(ENV)

# Colors for output
CYAN = \033[0;36m
GREEN = \033[0;32m
YELLOW = \033[1;33m
RED = \033[0;31m
NC = \033[0m # No Color

help: ## Show this help message
	@echo "$(CYAN)Terraform Project - Available Commands$(NC)"
	@echo ""
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "$(GREEN)%-15s$(NC) %s\n", $$1, $$2}' $(MAKEFILE_LIST)

init: ## Initialize Terraform
	@echo "$(YELLOW)Initializing Terraform for $(ENV) environment...$(NC)"
	cd $(APP_DIR) && terraform init

plan: ## Plan Terraform changes
	@echo "$(YELLOW)Planning Terraform changes for $(ENV) environment...$(NC)"
	cd $(APP_DIR) && terraform plan -var-file="../../$(CONFIG_DIR)/terraform.tfvars"

apply: ## Apply Terraform changes
	@echo "$(YELLOW)Applying Terraform changes for $(ENV) environment...$(NC)"
	cd $(APP_DIR) && terraform apply -var-file="../../$(CONFIG_DIR)/terraform.tfvars"

destroy: ## Destroy Terraform infrastructure
	@echo "$(RED)Destroying Terraform infrastructure for $(ENV) environment...$(NC)"
	cd $(APP_DIR) && terraform destroy -var-file="../../$(CONFIG_DIR)/terraform.tfvars"

fmt: ## Format Terraform files
	@echo "$(YELLOW)Formatting Terraform files...$(NC)"
	terraform fmt -recursive

validate: ## Validate Terraform configuration
	@echo "$(YELLOW)Validating Terraform configuration...$(NC)"
	cd $(APP_DIR) && terraform validate

lint: ## Run linting tools
	@echo "$(YELLOW)Running linting tools...$(NC)"
	@if command -v tflint >/dev/null 2>&1; then \
		tflint --init; \
		tflint --recursive; \
	else \
		echo "$(RED)tflint not installed. Skipping...$(NC)"; \
	fi
	@if command -v tfsec >/dev/null 2>&1; then \
		tfsec .; \
	else \
		echo "$(RED)tfsec not installed. Skipping...$(NC)"; \
	fi

security: ## Run security checks
	@echo "$(YELLOW)Running security checks...$(NC)"
	@if command -v tfsec >/dev/null 2>&1; then \
		tfsec --exclude-downloaded-modules .; \
	else \
		echo "$(RED)tfsec not installed. Please install it first.$(NC)"; \
	fi
	@if command -v checkov >/dev/null 2>&1; then \
		checkov -d . --framework terraform --skip-check CKV_AWS_20,CKV_AWS_57; \
	else \
		echo "$(RED)checkov not installed. Please install it first.$(NC)"; \
	fi

docs: ## Generate documentation
	@echo "$(YELLOW)Generating documentation...$(NC)"
	@if command -v terraform-docs >/dev/null 2>&1; then \
		terraform-docs markdown table --output-file README.md $(APP_DIR); \
		for module in modules/*/; do \
			terraform-docs markdown table --output-file README.md $$module; \
		done; \
	else \
		echo "$(RED)terraform-docs not installed. Please install it first.$(NC)"; \
	fi

clean: ## Clean Terraform files
	@echo "$(YELLOW)Cleaning Terraform files...$(NC)"
	find . -type f -name "*.tfstate*" -delete
	find . -type f -name "*.tfplan" -delete
	find . -type d -name ".terraform" -exec rm -rf {} + 2>/dev/null || true

check: fmt validate lint ## Run all checks (format, validate, lint)

# Environment-specific targets
dev: ## Set environment to dev
	$(MAKE) ENV=dev

stg: ## Set environment to stg
	$(MAKE) ENV=stg

prod: ## Set environment to prod
	$(MAKE) ENV=prod

# Complete workflows
dev-plan: ## Plan for dev environment
	$(MAKE) ENV=dev init plan

dev-apply: ## Apply for dev environment
	$(MAKE) ENV=dev init apply

stg-plan: ## Plan for stg environment
	$(MAKE) ENV=stg init plan

stg-apply: ## Apply for stg environment
	$(MAKE) ENV=stg init apply

prod-plan: ## Plan for prod environment
	$(MAKE) ENV=prod init plan

prod-apply: ## Apply for prod environment
	$(MAKE) ENV=prod init apply

# Installation helpers
install-tools: ## Install required tools
	@echo "$(YELLOW)Installing required tools...$(NC)"
	@echo "Installing tflint..."
	curl -s https://raw.githubusercontent.com/terraform-linters/tflint/master/install_linux.sh | bash
	@echo "Installing tfsec..."
	go install github.com/aquasecurity/tfsec/cmd/tfsec@latest
	@echo "Installing terraform-docs..."
	go install github.com/terraform-docs/terraform-docs@latest
	@echo "Installing checkov..."
	pip install checkov
	@echo "$(GREEN)All tools installed successfully!$(NC)"

# Help for environment variables
env-help: ## Show environment variables help
	@echo "$(CYAN)Environment Variables:$(NC)"
	@echo "  ENV    - Environment (dev, stg, prod) [default: dev]"
	@echo "  REGION - AWS region [default: us-east-1]"
	@echo ""
	@echo "$(CYAN)Examples:$(NC)"
	@echo "  make ENV=dev plan"
	@echo "  make ENV=prod apply"
	@echo "  make REGION=us-west-2 plan"