class Solution:
    def getDescentPeriods(self, prices: str) -> int:
        n = len(prices)
        if n == 0:
            return 0
        total = 1
        count = 1
        for i in range(1, n):
            if int(prices[i-1]) - int(prices[i]) == 1:
                count += 1
            else:
                count = 1
            total += count
        return total