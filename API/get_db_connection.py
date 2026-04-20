import os
from socket import timeout 
import pymssql
from dotenv import load_dotenv

load_dotenv()

def get_db_connection():
    server = os.getenv("DB_SERVER")
    database = os.getenv("DB_NAME")
    username = os.getenv("DB_USER")
    password = os.getenv("DB_PASSWORD")

    return pymssql.connect(
        server=server,
        user=username,
        password=password,
        database=database,
        port=1433,
        tds_version='7.4',
        timeout=30,
    )
    # ODBC driver 18 for SQL server can only be used in Synchronous mode
    # conn = pyodbc.connect(
    #     f"DRIVER={{ODBC Driver 18 for SQL Server}};"
    #     f"SERVER={server};"
    #     f"DATABASE={database};"
    #     f"UID={username};"
    #     f"PWD={password}; Encrypt=yes;TrustServerCertificate=yes;Connection Timeout=30;"
    # )

#     conn = pyodbc.connect(
#         f"DRIVER=/opt/homebrew/lib/libmsodbcsql.18.dylib;"
#         f"SERVER={server};"
#         f"DATABASE={database};"
#         f"UID={username};"
#         f"PWD={password};"
#         f"Encrypt=yes;"
#         f"TrustServerCertificate=yes;"
#         f"Connection Timeout=30;"
# )

#     return conn