class Solution:
    def diagonalSort(self, matrix: List[List[int]]) -> List[List[int]]:
        from collections import defaultdict
        import math

        rows = len(matrix)
        cols = len(matrix[0])

        diagonals = defaultdict(list)

        for i in range(rows):
            for j in range(cols):
                key = i - j
                diagonals[key].append(matrix[i][j])

        for key in diagonals:
            diagonals[key].sort()

        for i in range(rows):
            for j in range(cols):
                key = i - j
                matrix[i][j] = diagonals[key].pop(0)

        return matrix