class Solution:
    def diagonalSort(self, mat: List[List[int]]) -> List[List[int]]:
        from collections import defaultdict
        import math

        diagonals = defaultdict(list)
        rows, cols = len(mat), len(mat[0])

        for i in range(rows):
            for j in range(cols):
                key = i - j
                diagonals[key].append(mat[i][j])

        for key in diagonals:
            diagonals[key].sort()

        result = [[0] * cols for _ in range(rows)]

        for i in range(rows):
            for j in range(cols):
                key = i - j
                result[i][j] = diagonals[key].pop(0)

        return result