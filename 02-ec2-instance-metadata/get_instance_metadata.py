import json
import boto3

# Create an EC2 client
ec2 = boto3.client('ec2')

# Get the instance ID from the EC2 metadata service
instance_id = ec2.meta.client.get_instance_identity()['instanceId']

# Describe the instance using the instance ID
response = ec2.describe_instances(InstanceIds=[instance_id])

# Extract the metadata from the response
metadata = response['Reservations'][0]['Instances'][0]

# Convert the metadata to JSON format
json_output = json.dumps(metadata, default=str)

# Print the JSON output
print(json_output)
