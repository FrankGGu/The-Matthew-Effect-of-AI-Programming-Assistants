import pandas as pd

def getDataframeSize(df: pd.DataFrame) -> list[int]:
    return [df.shape[0], df.shape[1]]