#!/bin/bash

# ============================================================
# BILLING APP - MANUAL DEPLOYMENT SCRIPT
# Usage: ./deploy.sh staging|production
# ============================================================

set -e

ENVIRONMENT=$1

if [ -z "$ENVIRONMENT" ]; then
  echo "Usage: ./deploy.sh [staging|production]"
  exit 1
fi

echo "🚀 Deploying to $ENVIRONMENT..."

# Load environment config
if [ "$ENVIRONMENT" = "production" ]; then
  EC2_HOST="${PROD_EC2_HOST}"
  DOMAIN="${PROD_DOMAIN}"
elif [ "$ENVIRONMENT" = "staging" ]; then
  EC2_HOST="${STAGING_EC2_HOST}"
  DOMAIN="${STAGING_DOMAIN}"
else
  echo "Invalid environment"
  exit 1
fi

if [ -z "$EC2_HOST" ]; then
  echo "❌ EC2_HOST not set for $ENVIRONMENT"
  exit 1
fi

# Build backend
echo "📦 Building backend..."
cd ../../backend
npm install
npm run build

# Build frontend
echo "🎨 Building frontend..."
cd ../frontend
npm install
npm run build

# Deploy backend
echo "🚢 Deploying backend..."
rsync -avz --delete -e "ssh -o StrictHostKeyChecking=no" \
  ../backend/dist/ \
  ubuntu@$EC2_HOST:/var/www/billing-app/backend/dist/

# Deploy frontend
echo "🎨 Deploying frontend..."
rsync -avz --delete -e "ssh -o StrictHostKeyChecking=no" \
  ./build/ \
  ubuntu@$EC2_HOST:/var/www/billing-app/frontend/build/

# Restart services
echo "♻️  Restarting services..."
ssh ubuntu@$EC2_HOST << 'DEPLOY_EOF'
  cd /var/www/billing-app/backend
  npm ci --production
  pm2 restart billing-backend
  pm2 save
  sudo systemctl reload nginx
DEPLOY_EOF

echo "✅ Deployment to $ENVIRONMENT complete!"
