class Solution:
    def lenLongestFibTree(self, A: List[int]) -> int:
        n = len(A)
        dp = [[2] * n for _ in range(n)]
        seen = set(A)
        max_len = 0
        for j in range(n):
            for i in range(j):
                if A[i] - A[j] in seen:
                    k = A.index(A[i] - A[j])
                    if k < i:
                        dp[i][j] = dp[k][i] + 1
                max_len = max(max_len, dp[i][j])
        return max_len if max_len >= 3 else 0