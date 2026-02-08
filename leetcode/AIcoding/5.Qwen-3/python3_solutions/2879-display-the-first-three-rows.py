import pandas as pd

def display_first_three_rows(df: pd.DataFrame) -> pd.DataFrame:
    return df.head(3)