class Solution:
    def totalNQueens(self, n: int) -> int:
        def backtrack(row, diagonals, anti_diagonals, cols):
            if row == n:
                return 1
            count = 0
            for col in range(n):
                diagonal = row - col
                anti_diagonal = row + col
                if diagonal in diagonals or anti_diagonal in anti_diagonals or col in cols:
                    continue
                diagonals.add(diagonal)
                anti_diagonals.add(anti_diagonal)
                cols.add(col)
                count += backtrack(row + 1, diagonals, anti_diagonals, cols)
                diagonals.remove(diagonal)
                anti_diagonals.remove(anti_diagonal)
                cols.remove(col)
            return count

        return backtrack(0, set(), set(), set())