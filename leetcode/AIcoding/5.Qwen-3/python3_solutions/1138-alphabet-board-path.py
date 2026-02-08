class Solution:
    def alphabetBoardPath(self, target: str) -> str:
        board = ["abcde", "fghij", "klmno", "pqrst", "uvwxy", "z"]
        pos = {}
        for i in range(len(board)):
            for j in range(len(board[i])):
                pos[board[i][j]] = (i, j)

        res = []
        x, y = 5, 0
        for c in target:
            tx, ty = pos[c]
            if tx > x:
                res.append('D' * (tx - x))
            elif tx < x:
                res.append('U' * (x - tx))
            if ty > y:
                res.append('R' * (ty - y))
            elif ty < y:
                res.append('L' * (y - ty))
            res.append('.')
            x, y = tx, ty
        return ''.join(res)