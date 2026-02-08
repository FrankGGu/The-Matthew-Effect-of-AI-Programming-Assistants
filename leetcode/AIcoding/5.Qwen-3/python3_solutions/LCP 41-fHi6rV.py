class Solution:
    def flipChess(self, board: List[List[str]]) -> int:
        from collections import deque

        directions = [(-1, 0), (1, 0), (0, -1), (0, 1), (-1, -1), (-1, 1), (1, -1), (1, 1)]

        def bfs(start_x, start_y):
            queue = deque()
            queue.append((start_x, start_y))
            visited = set()
            visited.add((start_x, start_y))
            count = 0
            while queue:
                x, y = queue.popleft()
                for dx, dy in directions:
                    nx, ny = x + dx, y + dy
                    temp = []
                    while 0 <= nx < len(board) and 0 <= ny < len(board[0]) and board[nx][ny] == 'o':
                        temp.append((nx, ny))
                        nx += dx
                        ny += dy
                    if 0 <= nx < len(board) and 0 <= ny < len(board[0]) and board[nx][ny] == 'x':
                        for tx, ty in temp:
                            if (tx, ty) not in visited:
                                visited.add((tx, ty))
                                queue.append((tx, ty))
                                count += 1
            return count

        max_flips = 0
        for i in range(len(board)):
            for j in range(len(board[0])):
                if board[i][j] == 'o':
                    flips = bfs(i, j)
                    max_flips = max(max_flips, flips)
        return max_flips