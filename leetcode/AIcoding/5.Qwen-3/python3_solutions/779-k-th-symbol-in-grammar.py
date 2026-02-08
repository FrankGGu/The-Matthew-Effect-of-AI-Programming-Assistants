class Solution:
    def kthSymbol(self, n: int, k: int) -> int:
        def dfs(row, col):
            if row == 1:
                return 0
            parent = dfs(row - 1, (col + 1) // 2)
            if parent == 0:
                return 0 if col % 2 == 1 else 1
            else:
                return 1 if col % 2 == 1 else 0
        return dfs(n, k)