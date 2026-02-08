from typing import List
import pandas as pd

def maximumDifference(sales: List[int]) -> int:
    df = pd.DataFrame({'sales': sales})
    df['diff'] = df['sales'].diff()
    return df['diff'].max()