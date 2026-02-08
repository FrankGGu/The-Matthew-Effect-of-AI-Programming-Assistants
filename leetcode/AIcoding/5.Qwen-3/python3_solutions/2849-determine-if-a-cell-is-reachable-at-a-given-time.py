class Solution:
    def isReachable(self, tree: List[List[int]], moveTime: int, cell: List[int], time: int) -> bool:
        from collections import deque

        rows, cols = len(tree), len(tree[0])
        visited = [[False] * cols for _ in range(rows)]
        queue = deque()
        start_row, start_col = cell[0], cell[1]
        queue.append((start_row, start_col, 0))
        visited[start_row][start_col] = True

        while queue:
            r, c, t = queue.popleft()
            if t > time:
                continue
            if t == time:
                return True
            for dr, dc in [(-1, 0), (1, 0), (0, -1), (0, 1)]:
                nr, nc = r + dr, c + dc
                if 0 <= nr < rows and 0 <= nc < cols and not visited[nr][nc] and tree[nr][nc] <= time - t:
                    visited[nr][nc] = True
                    queue.append((nr, nc, t + 1))
        return False