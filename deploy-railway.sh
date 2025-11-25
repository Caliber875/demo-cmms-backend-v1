#!/bin/bash

# 🚀 Railway Quick Deploy Script
# This script helps you deploy your backend to Railway

echo "🚀 CMMS Backend - Railway Deployment"
echo "======================================"
echo ""

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check if Railway CLI is installed
echo -e "${BLUE}Checking for Railway CLI...${NC}"
if ! command -v railway &> /dev/null; then
    echo -e "${YELLOW}Railway CLI not found. Installing...${NC}"
    npm install -g @railway/cli
    if [ $? -ne 0 ]; then
        echo -e "${RED}❌ Failed to install Railway CLI${NC}"
        echo -e "${YELLOW}Please install manually: npm install -g @railway/cli${NC}"
        exit 1
    fi
    echo -e "${GREEN}✅ Railway CLI installed${NC}"
else
    echo -e "${GREEN}✅ Railway CLI found${NC}"
fi

echo ""
echo -e "${BLUE}Logging in to Railway...${NC}"
railway login

if [ $? -ne 0 ]; then
    echo -e "${RED}❌ Failed to login to Railway${NC}"
    exit 1
fi

echo ""
echo -e "${GREEN}✅ Logged in successfully${NC}"
echo ""

# Ask if they want to create a new project or link existing
echo -e "${YELLOW}Do you want to:${NC}"
echo "1) Create a NEW Railway project"
echo "2) Link to EXISTING Railway project"
read -p "Enter choice (1 or 2): " choice

if [ "$choice" = "1" ]; then
    echo ""
    echo -e "${BLUE}Creating new Railway project...${NC}"
    railway init
elif [ "$choice" = "2" ]; then
    echo ""
    echo -e "${BLUE}Linking to existing project...${NC}"
    railway link
else
    echo -e "${RED}❌ Invalid choice${NC}"
    exit 1
fi

if [ $? -ne 0 ]; then
    echo -e "${RED}❌ Failed to initialize/link project${NC}"
    exit 1
fi

echo ""
echo -e "${GREEN}✅ Project setup complete${NC}"
echo ""

# Set environment variables
echo -e "${BLUE}Setting environment variables...${NC}"
echo ""
echo -e "${YELLOW}Please enter your environment variables:${NC}"
echo ""

# MongoDB URI
read -p "MONGODB_URI (press Enter to use default from .env): " MONGODB_URI
if [ -z "$MONGODB_URI" ]; then
    MONGODB_URI="mongodb+srv://karthick1242004:9894783774@karthick124.8ruyxjc.mongodb.net/construction"
fi
railway variables set MONGODB_URI="$MONGODB_URI"

# JWT Secret
read -p "JWT_SECRET (press Enter to use default from .env): " JWT_SECRET
if [ -z "$JWT_SECRET" ]; then
    JWT_SECRET="TBBpEF7dvljMy4FZcsYsB9wj4fhwJ9r55EsnURlLY9BECFspDKIysalPDnLDT46v"
fi
railway variables set JWT_SECRET="$JWT_SECRET"

# Frontend URL
read -p "FRONTEND_URL (your Vercel frontend URL): " FRONTEND_URL
if [ -z "$FRONTEND_URL" ]; then
    FRONTEND_URL="https://demo-cmms-eight.vercel.app"
fi
railway variables set FRONTEND_URL="$FRONTEND_URL"

# Node Environment
railway variables set NODE_ENV="production"

echo ""
echo -e "${GREEN}✅ Environment variables set${NC}"
echo ""

# Build locally first to check for errors
echo -e "${BLUE}Testing build locally...${NC}"
npm run build

if [ $? -ne 0 ]; then
    echo -e "${RED}❌ Build failed locally. Please fix errors before deploying.${NC}"
    exit 1
fi

echo -e "${GREEN}✅ Local build successful${NC}"
echo ""

# Deploy
echo -e "${BLUE}Deploying to Railway...${NC}"
railway up

if [ $? -ne 0 ]; then
    echo -e "${RED}❌ Deployment failed${NC}"
    exit 1
fi

echo ""
echo -e "${GREEN}======================================"
echo "🎉 Deployment Successful!"
echo "======================================${NC}"
echo ""

# Get the domain
echo -e "${BLUE}Getting your deployment URL...${NC}"
DOMAIN=$(railway domain)

if [ $? -eq 0 ]; then
    echo ""
    echo -e "${GREEN}Your backend is live at:${NC}"
    echo -e "${BLUE}$DOMAIN${NC}"
    echo ""
    echo -e "${YELLOW}Next steps:${NC}"
    echo "1. Test your backend: curl $DOMAIN/health"
    echo "2. Update your frontend .env.local:"
    echo "   NEXT_PUBLIC_SERVER_URL=$DOMAIN"
    echo "3. Redeploy your frontend on Vercel"
else
    echo ""
    echo -e "${YELLOW}To generate a public domain:${NC}"
    echo "1. Go to https://railway.app"
    echo "2. Select your project"
    echo "3. Go to Settings → Networking"
    echo "4. Click 'Generate Domain'"
fi

echo ""
echo -e "${GREEN}Deployment complete! 🚀${NC}"

