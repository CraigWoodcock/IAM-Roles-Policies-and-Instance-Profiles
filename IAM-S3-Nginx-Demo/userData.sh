#!/bin/bash

set -e

echo "Updating package lists..."
sudo apt update -y

echo "Upgrading packages..."
sudo DEBIAN_FRONTEND=noninteractive apt upgrade -y

echo "Installing Nginx..."
sudo DEBIAN_FRONTEND=noninteractive apt install nginx -y

echo "Installing AWS CLI..."
sudo DEBIAN_FRONTEND=noninteractive apt install awscli -y

echo "Removing default website..."
sudo rm -rf /var/www/html/*

echo "Downloading website from S3..."

sudo aws s3 cp s3://craig-iam-s3-nginx-bucket/website/ /var/www/html/ --recursive

sudo systemctl enable nginx

sudo systemctl restart nginx

echo "Deployment Complete"