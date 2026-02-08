import pandas as pd

def find_conversion_rate(subscription: pd.DataFrame) -> pd.DataFrame:
    total_users = subscription.shape[0]
    converted_users = subscription[subscription['status'] == 'confirmed'].shape[0]
    conversion_rate = converted_users / total_users * 100
    return pd.DataFrame({'conversion_rate': [conversion_rate]})