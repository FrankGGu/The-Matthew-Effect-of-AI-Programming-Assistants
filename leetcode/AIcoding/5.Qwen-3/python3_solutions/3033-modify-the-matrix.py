class Solution:
    def modifyMatrix(self, matrix: List[List[int]]) -> List[List[int]]:
        m = len(matrix)
        n = len(matrix[0])
        result = [[0] * n for _ in range(m)]
        for i in range(m):
            for j in range(n):
                if matrix[i][j] == 0:
                    for k in range(n):
                        result[i][k] += 1
                    for k in range(m):
                        result[k][j] += 1
        for i in range(m):
            for j in range(n):
                if matrix[i][j] == 0:
                    result[i][j] = 0
        return result