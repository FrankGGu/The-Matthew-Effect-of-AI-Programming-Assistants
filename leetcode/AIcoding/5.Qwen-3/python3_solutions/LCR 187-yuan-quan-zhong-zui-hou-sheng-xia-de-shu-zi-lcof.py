class Solution:
    def findTheWinner(self, n: int, k: int) -> int:
        def dfs(n, k):
            if n == 1:
                return 0
            return (dfs(n - 1, k) + k) % n
        return dfs(n, k) + 1