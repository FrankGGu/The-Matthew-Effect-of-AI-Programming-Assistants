class Solution:
    def countSubIslands(self, grid1: List[List[int]], grid2: List[List[int]]) -> int:
        from collections import deque

        def bfs(i, j):
            queue = deque([(i, j)])
            grid2[i][j] = 0
            is_sub = True
            while queue:
                x, y = queue.popleft()
                if grid1[x][y] != 1:
                    is_sub = False
                for dx, dy in [(-1, 0), (1, 0), (0, -1), (0, 1)]:
                    nx, ny = x + dx, y + dy
                    if 0 <= nx < len(grid2) and 0 <= ny < len(grid2[0]) and grid2[nx][ny] == 1:
                        grid2[nx][ny] = 0
                        queue.append((nx, ny))
            return is_sub

        count = 0
        for i in range(len(grid2)):
            for j in range(len(grid2[0])):
                if grid2[i][j] == 1:
                    if bfs(i, j):
                        count += 1
        return count