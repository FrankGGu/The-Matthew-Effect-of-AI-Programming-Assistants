class Solution:
    def bag(self, capacity: int, weights: List[int], values: int) -> int:
        n = len(weights)
        dp = [0] * (capacity + 1)
        for i in range(n):
            for j in range(capacity, weights[i] - 1, -1):
                dp[j] = max(dp[j], dp[j - weights[i]] + values[i])
        return dp[capacity]