#!/bin/bash

# Create backend folder structure
mkdir -p backend/src/{controllers,models,routes,middleware,utils}
mkdir -p backend/prisma
mkdir -p backend/tests
mkdir -p backend/.github

# Create frontend folder structure
mkdir -p frontend/public
mkdir -p frontend/src/{components,pages,hooks,utils,styles}

# Create infrastructure folder structure
mkdir -p infrastructure/terraform
mkdir -p infrastructure/scripts
mkdir -p infrastructure/docker

# Create workflows folder
mkdir -p .github/workflows

echo "✅ Folder structure created"