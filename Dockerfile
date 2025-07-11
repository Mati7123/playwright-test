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
RUN pwsh bin/Debug/net7.0/playwright.ps1 install

# Komenda, która odpali testy (testy muszą być w Twoim projekcie)
CMD ["dotnet", "test", "--logger:trx"]
