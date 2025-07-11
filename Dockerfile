# Używamy oficjalnego obrazu Microsoft z .NET SDK (np. .NET 7)
FROM mcr.microsoft.com/dotnet/sdk:7.0

# Ustawiamy katalog roboczy w kontenerze
WORKDIR /app

# Kopiujemy pliki projektu do kontenera
COPY . .

# Przywracamy zależności (nuget)
RUN dotnet restore

# Budujemy projekt
RUN dotnet build --configuration Release

# Instalujemy Playwright (pobiera przeglądarki)
RUN dotnet tool install --global Microsoft.Playwright.CLI
RUN export PATH="$PATH:/root/.dotnet/tools"
RUN ls -R bin
RUN chmod +x bin/Release/net7.0/playwright.ps1 && \
    pwsh bin/Release/net7.0/playwright.ps1 install
RUN apt-get update && apt-get install -y \
    libglib2.0-0 \
    libnspr4 \
    libnss3 \
    libdbus-1-3 \
    libatk1.0-0 \
    libatk-bridge2.0-0 \
    libatspi2.0-0 \
    libx11-6 \
    libxcomposite1 \
    libxdamage1 \
    libxext6 \
    libxfixes3 \
    libxrandr2 \
    libgbm1 \
    libxcb1 \
    libxkbcommon0 \
    libasound2 \
 && rm -rf /var/lib/apt/lists/*

# Komenda, która odpali testy (testy muszą być w Twoim projekcie)
CMD ["dotnet", "test", "--logger:trx"]
