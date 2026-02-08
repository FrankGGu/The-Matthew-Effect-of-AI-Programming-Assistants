class Solution:
    def canMouseWin(self, grid: List[str], k: int) -> bool:
        from collections import deque

        m, n = len(grid), len(grid[0])
        mouse_pos = []
        cat_pos = []
        for i in range(m):
            for j in range(n):
                if grid[i][j] == 'M':
                    mouse_pos = [i, j]
                elif grid[i][j] == 'C':
                    cat_pos = [i, j]

        directions = [[-1, 0], [1, 0], [0, -1], [0, 1]]

        memo = {}

        def dfs(mouse, cat, turn):
            if (mouse, cat, turn) in memo:
                return memo[(mouse, cat, turn)]
            if turn >= 2 * k:
                return False
            if mouse == cat:
                return False
            if grid[mouse[0]][mouse[1]] == 'W':
                return True
            if turn % 2 == 0:
                # Mouse's turn
                for d in directions:
                    new_mouse = [mouse[0] + d[0], mouse[1] + d[1]]
                    if 0 <= new_mouse[0] < m and 0 <= new_mouse[1] < n:
                        if grid[new_mouse[0]][new_mouse[1]] != 'D':
                            if dfs(new_mouse, cat, turn + 1):
                                memo[(mouse, cat, turn)] = True
                                return True
                memo[(mouse, cat, turn)] = False
                return False
            else:
                # Cat's turn
                for d in directions:
                    new_cat = [cat[0] + d[0], cat[1] + d[1]]
                    if 0 <= new_cat[0] < m and 0 <= new_cat[1] < n:
                        if grid[new_cat[0]][new_cat[1]] != 'D':
                            if not dfs(mouse, new_cat, turn + 1):
                                memo[(mouse, cat, turn)] = False
                                return False
                memo[(mouse, cat, turn)] = True
                return True

        return dfs(mouse_pos, cat_pos, 0)