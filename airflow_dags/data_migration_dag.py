from airflow import DAG
from airflow.providers.amazon.aws.operators.glue import AwsGlueJobOperator
from airflow.providers.amazon.aws.operators.dms import DmsStartReplicationTaskOperator
from airflow.utils.dates import days_ago

default_args = {
    'owner': 'airflow',
    'email_on_failure': False,
    'email_on_retry': False,
}

with DAG(
    'data_migration_dag',
    default_args=default_args,
    description='Data migration and processing DAG',
    schedule_interval='@daily',
    start_date=days_ago(1),
    tags=['data_migration'],
) as dag:

    start_dms_replication = DmsStartReplicationTaskOperator(
        task_id='start_dms_replication',
        replication_task_arn='arn:aws:dms:us-west-2:123456789012:task:YOUR_DMS_TASK_ARN',
        start_replication_task_type='reload-target',
    )

    run_glue_job = AwsGlueJobOperator(
        task_id='run_glue_job',
        job_name='your-glue-job-name',
        iam_role_name='AWSGlueServiceRole',
        script_location='s3://path-to-your-glue-script',
    )

    start_dms_replication >> run_glue_job