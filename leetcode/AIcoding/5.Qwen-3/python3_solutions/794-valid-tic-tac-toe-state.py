class Solution:
    def validTicTacToe(self, board: List[str]) -> bool:
        def countPlayer(player):
            return sum(row.count(player) for row in board)

        x_count = countPlayer('X')
        o_count = countPlayer('O')

        if o_count > x_count or x_count - o_count > 1:
            return False

        def checkWin(player):
            for i in range(3):
                if all(board[i][j] == player for j in range(3)):
                    return True
                if all(board[j][i] == player for j in range(3)):
                    return True
            if all(board[i][i] == player for i in range(3)):
                return True
            if all(board[i][2-i] == player for i in range(3)):
                return True
            return False

        x_win = checkWin('X')
        o_win = checkWin('O')

        if x_win and o_win:
            return False

        if x_win and x_count != o_count + 1:
            return False

        if o_win and x_count != o_count:
            return False

        return True