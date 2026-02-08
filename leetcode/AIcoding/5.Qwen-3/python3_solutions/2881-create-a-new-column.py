import pandas as pd

def createNewColumn(data: pd.DataFrame) -> pd.DataFrame:
    data['team'] = 'A'
    return data