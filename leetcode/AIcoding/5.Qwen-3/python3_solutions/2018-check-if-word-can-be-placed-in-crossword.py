class Solution:
    def placeWordInCrossword(self, board: List[List[str]], word: str) -> bool:
        m, n = len(board), len(board[0])
        directions = [(0, 1), (1, 0)]
        word_len = len(word)

        def check(x, y, dx, dy):
            for i in range(word_len):
                if x < 0 or x >= m or y < 0 or y >= n or board[x][y] != ' ' and board[x][y] != word[i]:
                    return False
                x += dx
                y += dy
            return True

        for i in range(m):
            for j in range(n):
                if board[i][j] == ' ' or board[i][j] == word[0]:
                    for dx, dy in directions:
                        ni, nj = i + dx, j + dy
                        if check(i, j, dx, dy):
                            return True
        return False