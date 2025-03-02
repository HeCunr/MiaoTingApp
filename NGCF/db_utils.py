#NGCF/db_utils.py
import mysql.connector
import pandas as pd
import os

class DBConnector:
    def __init__(self):
        self.conn = mysql.connector.connect(
            host='111.229.173.12',
            port=3306,
            user='root',
            password='@Aa123456'
        )
        self.cursor = self.conn.cursor()

    def read_file_from_db(self, file_path):
        query = f"SELECT content FROM data_files WHERE file_path = '{file_path}'"
        self.cursor.execute(query)
        content = self.cursor.fetchone()[0]

        # 将内容写入临时文件
        temp_path = f"temp_{os.path.basename(file_path)}"
        with open(temp_path, 'w') as f:
            f.write(content)
        return temp_path

    def write_results_to_db(self, results, file_path='/data/result.txt'):
        # 将结果转换为字符串
        content = '\n'.join([f"{user_id}\t{','.join(map(str, items))}"
                             for user_id, items in results])

        query = f"INSERT INTO data_files (file_path, content) VALUES ('{file_path}', '{content}')"
        self.cursor.execute(query)
        self.conn.commit()

    def close(self):
        self.cursor.close()
        self.conn.close()