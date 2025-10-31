#!/bin/bash

# ============================================================
# BILLING APP - AWS EC2 BOOTSTRAP SCRIPT
# This runs automatically when EC2 instance starts (user_data)
# ============================================================

set -e

echo "🚀 Starting server provisioning..."

# Update system
apt update
apt upgrade -y
apt install -y curl git nano ufw nginx nodejs npm postgresql postgresql-contrib redis-server build-essential certbot python3-certbot-nginx

# Install Node.js LTS
curl -fsSL https://deb.nodesource.com/setup_20.x | bash -
apt install -y nodejs

# Install global tools
npm install -g pm2 yarn

# Create app directories
mkdir -p /var/www/billing-app/{backend,frontend,logs,backups}
cd /var/www/billing-app

# Clone or download backend code
# git clone https://github.com/SS-CloudMaster/billing-saas.git .

# Setup backend
cd backend
npm install
cp .env.example .env

# Start backend with PM2
pm2 start npm --name "billing-backend" -- start
pm2 save
pm2 startup

# Setup Nginx
cat > /etc/nginx/sites-available/billing-app <<'NGINX_EOF'
upstream backend {
    server localhost:3000;
}

server {
    listen 80;
    server_name _;

    root /var/www/billing-app/frontend/build;
    index index.html;

    location / {
        try_files $uri $uri/ /index.html;
    }

    location /api {
        proxy_pass http://backend;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }
}
NGINX_EOF

ln -sf /etc/nginx/sites-available/billing-app /etc/nginx/sites-enabled/
rm -f /etc/nginx/sites-enabled/default
nginx -t
systemctl restart nginx

# Setup Firewall
ufw default deny incoming
ufw default allow outgoing
ufw allow 22/tcp
ufw allow 80/tcp
ufw allow 443/tcp
ufw enable -y

# Setup automatic backup cron
cat > /usr/local/bin/backup-billing.sh <<'BACKUP_EOF'
#!/bin/bash
BACKUP_DIR="/var/www/billing-app/backups"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
mkdir -p $BACKUP_DIR
# Add your backup commands here
# Example: pg_dump billing_db > $BACKUP_DIR/billing_db_$TIMESTAMP.sql
BACKUP_EOF

chmod +x /usr/local/bin/backup-billing.sh

# Add to crontab (daily at 2 AM)
(crontab -l 2>/dev/null; echo "0 2 * * * /usr/local/bin/backup-billing.sh") | crontab -

echo "✅ Provisioning complete!"
