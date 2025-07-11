#!/bin/bash
set -ex

echo "ENTRYPOINT SH START"

echo "📥 Pobieram plik z Azure Blob Storage..."
azcopy copy "$AZCOPY_URL" "/app/Test1.cs"

echo "🧪 Uruchamiam testy..."
dotnet test /app/playwright-test.csproj --logger trx --logger "console;verbosity=detailed"
sleep infinity
