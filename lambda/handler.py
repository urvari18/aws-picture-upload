import boto3
import base64
import os
import uuid

s3 = boto3.client('s3')
bucket = os.environ['BUCKET_NAME']

def lambda_handler(event, context):
    try:
        body = event['body']
        image_data = base64.b64decode(body)
        image_id = str(uuid.uuid4())
        key = f"{image_id}.jpg"

        s3.put_object(Bucket=bucket, Key=key, Body=image_data, ContentType='image/jpeg')

        return {
            "statusCode": 200,
            "body": f"Image uploaded successfully with key: {key}"
        }
    except Exception as e:
        return {
            "statusCode": 500,
            "body": str(e)
        }
