class Solution:
    def superEggDrop(self, K: int, N: int) -> int
        dp = [0] * (K + 1)
        m = 0
        while dp[K] < N:
            m += 1
            for j in range(K, 0, -1):
                dp[j] = dp[j] + dp[j-1] + 1
        return m