class Solution:
    def movesToChessboard(self, board: List[List[int]]) -> int:
        n = len(board)
        row_swaps = 0
        col_swaps = 0
        for i in range(n):
            if board[i][0] != i % 2:
                row_swaps += 1
            if board[0][i] != i % 2:
                col_swaps += 1
        if n % 2 == 0:
            if row_swaps % 2 != 0 or col_swaps % 2 != 0:
                return -1
        else:
            if row_swaps % 2 != 0 and col_swaps % 2 != 0:
                return -1
            if row_swaps % 2 != 0:
                row_swaps = n - row_swaps
            if col_swaps % 2 != 0:
                col_swaps = n - col_swaps
        return (row_swaps + col_swaps) // 2