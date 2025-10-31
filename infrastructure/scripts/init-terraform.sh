#!/bin/bash

# ============================================================
# INITIALIZE TERRAFORM
# Usage: ./init-terraform.sh
# ============================================================

cd ../terraform

echo "🔧 Initializing Terraform..."
terraform init

echo "📋 Validating configuration..."
terraform validate

echo "📊 Planning infrastructure..."
terraform plan -out=tfplan

echo "✅ Terraform initialized!"
echo ""
echo "Next steps:"
echo "1. Review the plan above"
echo "2. Run: terraform apply tfplan"
echo ""
