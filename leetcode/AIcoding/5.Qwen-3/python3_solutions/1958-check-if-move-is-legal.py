class Solution:
    def checkMove(self, board: List[List[str]], rStart: int, cStart: int, dR: int, dC: int) -> bool:
        steps = 1
        while 0 <= rStart + dR * steps < len(board) and 0 <= cStart + dC * steps < len(board[0]):
            if board[rStart + dR * steps][cStart + dC * steps] == 'B':
                return True
            if board[rStart + dR * steps][cStart + dC * steps] == 'W':
                break
            steps += 1
        return False