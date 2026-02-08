import pandas as pd

def dropDuplicateRows(employees: pd.DataFrame) -> pd.DataFrame:
    return employees.drop_duplicates()