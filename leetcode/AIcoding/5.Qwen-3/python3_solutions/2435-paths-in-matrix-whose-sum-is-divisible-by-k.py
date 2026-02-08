class Solution:
    def pathSum(self, matrix: List[List[int]], k: int) -> int:
        from collections import defaultdict

        m, n = len(matrix), len(matrix[0])
        dp = [[defaultdict(int) for _ in range(n)] for _ in range(m)]
        dp[0][0][matrix[0][0] % k] = 1

        for i in range(m):
            for j in range(n):
                if i == 0 and j == 0:
                    continue
                curr = matrix[i][j]
                temp = defaultdict(int)
                if i > 0:
                    for rem, cnt in dp[i-1][j].items():
                        new_rem = (rem + curr) % k
                        temp[new_rem] += cnt
                if j > 0:
                    for rem, cnt in dp[i][j-1].items():
                        new_rem = (rem + curr) % k
                        temp[new_rem] += cnt
                dp[i][j] = temp

        return dp[m-1][n-1][0]