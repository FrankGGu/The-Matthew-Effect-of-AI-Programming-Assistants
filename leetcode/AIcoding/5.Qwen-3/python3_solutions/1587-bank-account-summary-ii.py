import pandas as pd

def accountSummaryTable(users: pd.DataFrame, transactions: pd.DataFrame) -> pd.DataFrame:
    transactions['amount'] = transactions['amount'].astype(int)
    grouped = transactions.groupby('account').agg(total_amount=('amount', 'sum')).reset_index()
    result = pd.merge(users, grouped, left_on='account', right_on='account', how='left')
    result = result[['name', 'total_amount']]
    return result