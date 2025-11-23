FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /src
COPY ["DevOpsApi.csproj", "./"]

RUN dotnet restore "./DevOpsApi.csproj"
COPY . .
RUN dotnet build "DevOpsApi.csproj" -c Release -o /app/build

FROM mcr.microsoft.com/dotnet/aspnet:9.0
WORKDIR /app

COPY --from=build /app/build .

ENTRYPOINT ["dotnet","DevOpsApi.dll"]