FROM mcr.microsoft.com/dotnet/nightly/sdk:7.0-alpine3.17 AS build
WORKDIR /api
COPY api/*.csproj .
RUN dotnet restore
COPY api .
RUN dotnet publish -c Release -o /publish

FROM mcr.microsoft.com/dotnet/aspnet:7.0.5-alpine3.17 AS base
WORKDIR /publish
COPY --from=build /publish .
EXPOSE 80
ENTRYPOINT ["dotnet", "api.dll"]