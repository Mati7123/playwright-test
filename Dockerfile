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
    pwsh bin/Release/net7.0/playwright.ps1 install-deps && \
    pwsh bin/Release/net7.0/playwright.ps1 install
    
RUN wget -O azcopy.tar.gz https://aka.ms/downloadazcopy-v10-linux && \
    tar -xf azcopy.tar.gz --strip-components=1 && \
    mv azcopy /usr/bin/azcopy && \
    chmod +x /usr/bin/azcopy
    
# Komenda, która odpali testy (testy muszą być w Twoim projekcie)
entrypoint.sh
