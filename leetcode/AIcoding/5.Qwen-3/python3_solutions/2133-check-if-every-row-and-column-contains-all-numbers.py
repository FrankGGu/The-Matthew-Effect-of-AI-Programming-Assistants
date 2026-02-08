class Solution:
    def checkValidMatrix(self, matrix: List[List[int]]) -> bool:
        n = len(matrix)
        for row in matrix:
            if len(set(row)) != n:
                return False
        for j in range(n):
            col = [matrix[i][j] for i in range(n)]
            if len(set(col)) != n:
                return False
        return True