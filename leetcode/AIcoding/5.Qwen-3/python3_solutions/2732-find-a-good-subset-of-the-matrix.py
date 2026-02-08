class Solution:
    def findGoodSubset(self, matrix: List[List[int]]) -> List[int]:
        from collections import defaultdict

        rows = len(matrix)
        cols = len(matrix[0]) if rows > 0 else 0

        row_sums = [sum(row) for row in matrix]
        col_sums = [sum(matrix[i][j] for i in range(rows)) for j in range(cols)]

        row_set = set()
        col_set = set()

        for i in range(rows):
            if row_sums[i] == 0:
                row_set.add(i)

        for j in range(cols):
            if col_sums[j] == 0:
                col_set.add(j)

        result = []
        for i in row_set:
            result.append(i)
        for j in col_set:
            result.append(j + rows)

        return result