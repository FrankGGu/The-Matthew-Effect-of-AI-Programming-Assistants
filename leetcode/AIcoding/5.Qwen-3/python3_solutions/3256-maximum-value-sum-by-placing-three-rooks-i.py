class Solution:
    def maximumValueSum(self, board: List[List[int]]) -> int:
        rows = [0] * 8
        cols = [0] * 8
        for i in range(8):
            for j in range(8):
                rows[i] = max(rows[i], board[i][j])
                cols[j] = max(cols[j], board[i][j])
        return sum(rows) + sum(cols)