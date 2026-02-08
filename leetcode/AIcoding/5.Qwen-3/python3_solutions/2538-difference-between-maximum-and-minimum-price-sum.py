class Solution:
    def maxSum(self, prices: List[int], k: int) -> int:
        n = len(prices)
        dp = [[0] * (k + 1) for _ in range(n)]
        for i in range(n):
            dp[i][1] = prices[i]
        for j in range(2, k + 1):
            for i in range(n):
                for m in range(i):
                    dp[i][j] = max(dp[i][j], dp[m][j - 1] + prices[i])
        return max(dp[i][k] for i in range(n))