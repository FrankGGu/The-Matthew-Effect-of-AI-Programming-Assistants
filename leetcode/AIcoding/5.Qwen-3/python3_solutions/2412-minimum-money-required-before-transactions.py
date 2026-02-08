class Solution:
    def minimumMoney(self, transactions: List[List[int]]) -> int:
        transactions.sort(key=lambda x: (x[0] - x[1], x[1]))
        res = 0
        for t in transactions:
            if res < t[0]:
                res = t[0]
            res -= t[1]
        return res