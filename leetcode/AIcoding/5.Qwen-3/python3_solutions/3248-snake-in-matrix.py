class Solution:
    def finalPosition(self, matrix: List[List[int]]) -> int:
        m = len(matrix)
        n = len(matrix[0])
        i, j = 0, 0
        while True:
            if matrix[i][j] == 1:
                i += 1
            elif matrix[i][j] == 2:
                j += 1
            elif matrix[i][j] == 3:
                i -= 1
            elif matrix[i][j] == 4:
                j -= 1
            if i < 0 or i >= m or j < 0 or j >= n:
                return -1
            if matrix[i][j] == 5:
                return i * n + j