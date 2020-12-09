FROM mcr.microsoft.com/dotnet/aspnet:5.0 AS base
WORKDIR /app
EXPOSE 5000

FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build
WORKDIR /src
COPY ["comc1754-netcore-webapp.csproj", "./"]
RUN dotnet restore "comc1754-netcore-webapp.csproj"
COPY . .
WORKDIR "/src/."
RUN dotnet build "comc1754-netcore-webapp.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "comc1754-netcore-webapp.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "comc1754-netcore-webapp.dll"]