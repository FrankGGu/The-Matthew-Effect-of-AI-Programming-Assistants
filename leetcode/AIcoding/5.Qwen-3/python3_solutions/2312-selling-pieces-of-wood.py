class Solution:
    def sellingWood(self, n: int, prices: List[List[int]]) -> int:
        dp = [[0] * (n + 1) for _ in range(n + 1)]
        for length, price in prices:
            dp[length][1] = max(dp[length][1], price)
        for length in range(1, n + 1):
            for k in range(1, length):
                dp[length][1] = max(dp[length][1], dp[k][1] + dp[length - k][1])
        for width in range(2, n + 1):
            for length in range(1, n + 1):
                dp[length][width] = dp[length][width - 1]
                for k in range(1, length):
                    dp[length][width] = max(dp[length][width], dp[k][width] + dp[length - k][width])
        return dp[n][n]