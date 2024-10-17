#!/bin/bash
# Update and install dependencies
sudo apt update -y
sudo apt install -y python3-pip python3-venv

# Set up Python virtual environment
python3 -m venv airflow-venv
source airflow-venv/bin/activate

# Install Airflow
pip install apache-airflow[aws]==${airflow_version}

# Initialize Airflow
export AIRFLOW_HOME=~/airflow
airflow db init

# Create Airflow user
airflow users create \
    --username admin \
    --firstname Admin \
    --lastname User \
    --role Admin \
    --email admin@example.com \
    --password admin

# Start Airflow services
nohup airflow webserver --port 8080 &
nohup airflow scheduler &
