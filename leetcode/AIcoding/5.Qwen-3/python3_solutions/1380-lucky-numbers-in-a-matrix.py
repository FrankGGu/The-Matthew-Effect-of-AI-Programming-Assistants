class Solution:
    def luckyNumbers(self, matrix: List[List[int]]) -> List[int]:
        rows = len(matrix)
        cols = len(matrix[0])
        min_in_rows = [min(row) for row in matrix]
        max_in_cols = [max(matrix[i][j] for i in range(rows)) for j in range(cols)]
        result = []
        for i in range(rows):
            for j in range(cols):
                if matrix[i][j] == min_in_rows[i] and matrix[i][j] == max_in_cols[j]:
                    result.append(matrix[i][j])
        return result