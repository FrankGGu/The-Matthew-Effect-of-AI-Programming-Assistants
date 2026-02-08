import pandas as pd

def create_dataframe(students: list) -> pd.DataFrame:
    return pd.DataFrame(students, columns=['student_id', 'name', 'age'])