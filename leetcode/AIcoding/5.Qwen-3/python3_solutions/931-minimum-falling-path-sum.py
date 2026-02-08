class Solution:
    def minFallingPathSum(self, matrix: List[List[int]]) -> int:
        n = len(matrix)
        for i in range(1, n):
            for j in range(n):
                min_prev = min(matrix[i-1][j-1] if j-1 >= 0 else float('inf'), matrix[i-1][j], matrix[i-1][j+1] if j+1 < n else float('inf'))
                matrix[i][j] += min_prev
        return min(matrix[-1])