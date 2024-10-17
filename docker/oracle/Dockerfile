# Use Oracle Linux as the base image
FROM oraclelinux:7-slim

# Set environment variables
ENV ORACLE_BASE=/opt/oracle \
    ORACLE_HOME=/opt/oracle/product/11.2.0/xe \
    ORACLE_SID=XE \
    PATH=$ORACLE_HOME/bin:$PATH

# Install required packages and dependencies
RUN yum -y install unzip libaio bc initscripts net-tools hostname && \
    yum clean all

# Copy Oracle XE RPM (You need to download this manually from Oracle's website)
COPY oracle-xe-11.2.0-1.0.x86_64.rpm.zip /tmp/

# Unzip and install Oracle XE
RUN unzip /tmp/oracle-xe-11.2.0-1.0.x86_64.rpm.zip -d /tmp && \
    rpm -i /tmp/Disk1/oracle-xe-11.2.0-1.0.x86_64.rpm && \
    rm -rf /tmp/*

# Copy configuration response file
COPY oracle-xe.conf /etc/

# Configure Oracle XE
RUN /etc/init.d/oracle-xe configure responseFile=/etc/oracle-xe.conf

# Expose ports
EXPOSE 1521 8080

# Start the Oracle service
CMD ["/usr/sbin/startup.sh"]
