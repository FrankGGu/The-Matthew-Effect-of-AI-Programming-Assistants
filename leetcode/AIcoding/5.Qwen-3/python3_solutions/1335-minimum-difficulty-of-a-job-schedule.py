class Solution:
    def minDifficulty(self, jobDifficulty: List[int], d: int) -> int:
        n = len(jobDifficulty)
        if n < d:
            return -1
        dp = [[float('inf')] * (d + 1) for _ in range(n)]
        dp[0][1] = jobDifficulty[0]
        for i in range(1, n):
            dp[i][1] = max(dp[i-1][1], jobDifficulty[i])
        for k in range(2, d + 1):
            for i in range(k-1, n):
                current_max = jobDifficulty[i]
                for j in range(i, k-2, -1):
                    current_max = max(current_max, jobDifficulty[j])
                    dp[i][k] = min(dp[i][k], dp[j-1][k-1] + current_max)
        return dp[n-1][d]