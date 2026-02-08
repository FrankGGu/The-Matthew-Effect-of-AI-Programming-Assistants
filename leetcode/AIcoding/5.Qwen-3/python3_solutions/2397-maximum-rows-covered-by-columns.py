class Solution:
    def maximumRows(self, matrix: List[List[int]], cols: int) -> int:
        from collections import defaultdict

        row_mask = []
        for row in matrix:
            mask = 0
            for j, val in enumerate(row):
                if val == 1:
                    mask |= 1 << j
            row_mask.append(mask)

        max_rows = 0
        n = len(matrix[0])
        for mask in range(1 << n):
            count = bin(mask).count('1')
            if count != cols:
                continue
            covered = 0
            for r in row_mask:
                if (r & mask) == r:
                    covered += 1
            max_rows = max(max_rows, covered)
        return max_rows