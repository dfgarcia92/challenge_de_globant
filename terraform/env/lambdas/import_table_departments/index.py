import json
import os
import awswrangler as wr
import pandas as pd

PATH = os.environ['S3_PATH'] 
DB_NAME = os.environ['DATABASE_NAME'] 
TABLE_NAME = os.environ['TABLE_NAME']

def lambda_handler(event, context):
    
    path_s3 = PATH + TABLE_NAME + '/'
    print('reading csv...')
    print("STRING EVENT ", event) # Daily table
    s3_daily_file = event['file_path'] 
    
    try:
        existing_df = wr.s3.read_parquet(path = path_s3)
        print('existing_df')
    except:
        print('no existing_df')
        existing_df = None
    
    df = wr.s3.read_csv(path = s3_daily_file, header=None, names=['id', 'department'], na_values="")
    

    if existing_df is not None:
        existing_ids = set(existing_df['id'])  
        df = df[~df['id'].isin(existing_ids)]

    #create table in parquet format in s3
    print('creating table...')
    wr.s3.to_parquet(
        df=df,
        path=path_s3,
        dataset=True,
        database=DB_NAME,
        table=TABLE_NAME,
        mode="overwrite",
    )
    
    return {
        'statusCode': 200,
        'body': json.dumps('Finaliza la ejecución correctamente.')
    }    
