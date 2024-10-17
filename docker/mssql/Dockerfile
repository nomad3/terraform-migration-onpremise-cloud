# Use the official Microsoft SQL Server image
FROM mcr.microsoft.com/mssql/server:2019-latest

# Set environment variables
ENV ACCEPT_EULA=Y \
    SA_PASSWORD=YourStrong!Passw0rd

# Expose SQL Server port
EXPOSE 1433

# Copy initialization script
COPY init.sql /init.sql

# Run SQL Server and initialize the database
CMD /bin/bash -c "/opt/mssql/bin/sqlservr & sleep 15 && \
   /opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P '$SA_PASSWORD' -i /init.sql && \
   tail -f /dev/null"
