#!/bin/bash

set -e

echo "Updating package lists..."
apt update -y

echo "Upgrading packages..."
DEBIAN_FRONTEND=noninteractive apt upgrade -y

echo "Installing Nginx..."
apt install nginx -y

echo "Installing AWS CLI..."
apt install awscli -y

echo "Removing default website..."
rm -rf /var/www/html/*

echo "Downloading website from S3..."

aws s3 cp s3://craig-iam-s3-nginx-bucket/website/ /var/www/html/ --recursive

systemctl enable nginx

systemctl restart nginx

echo "Deployment Complete"craig-iam-s3-nginx-bucket