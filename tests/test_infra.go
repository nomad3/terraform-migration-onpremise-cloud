package tests

import (
    "testing"

    "github.com/gruntwork-io/terratest/modules/aws"
    "github.com/gruntwork-io/terratest/modules/terraform"
    "github.com/stretchr/testify/assert"
)

func TestTerraformAWSInfrastructure(t *testing.T) {
    t.Parallel()

    terraformOptions := &terraform.Options{
        TerraformDir: "../terraform",
    }

    defer terraform.Destroy(t, terraformOptions)
    terraform.InitAndApply(t, terraformOptions)

    vpcID := terraform.Output(t, terraformOptions, "vpc_id")
    bucketName := terraform.Output(t, terraformOptions, "s3_bucket_name")

    // Test VPC
    vpc := aws.GetVpcById(t, vpcID, "us-west-2")
    assert.Equal(t, "10.0.0.0/16", *vpc.CidrBlock)

    // Test S3 Bucket
    aws.AssertS3BucketExists(t, "us-west-2", bucketName)
}
