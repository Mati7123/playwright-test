#!/bin/bash
set -ex
echo "ENTRYPOINT SH START"

echo "📥 Pobieram plik z Azure Blob Storage..."
azcopy copy "$AZCOPY_URL" "/app/playwright_test/Test1.cs"

echo "🧪 Uruchamiam testy..."
dotnet test /app/playwright-test.csproj --logger:trx
