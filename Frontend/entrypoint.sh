#!/bin/sh

echo "🌱 Reemplazando variables en environment.ts"
envsubst < src/environments/environment.template.ts > src/environments/environment.ts

echo "⚙️ Building Angular..."
npm run build

echo "🚀 Starting server..."
node dist/frontend/server/server.mjs