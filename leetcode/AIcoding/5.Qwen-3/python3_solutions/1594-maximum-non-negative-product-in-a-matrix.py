class Solution:
    def maxValue(self, matrix: List[List[int]]) -> int:
        m, n = len(matrix), len(matrix[0])
        MOD = 10**9 + 7

        dp = [[(0, 0) for _ in range(n)] for _ in range(m)]
        dp[0][0] = (matrix[0][0], matrix[0][0])

        for i in range(m):
            for j in range(n):
                if i == 0 and j == 0:
                    continue
                candidates = []
                if i > 0:
                    candidates.append(dp[i-1][j][0])
                    candidates.append(dp[i-1][j][1])
                if j > 0:
                    candidates.append(dp[i][j-1][0])
                    candidates.append(dp[i][j-1][1])
                max_val = max(candidates)
                min_val = min(candidates)
                dp[i][j] = (max_val * matrix[i][j], min_val * matrix[i][j])

        return dp[m-1][n-1][0] % MOD