class Solution:
    def minFlips(self, mat: List[List[int]]) -> int:
        from collections import deque

        m, n = len(mat), len(mat[0])
        state = 0
        for i in range(m):
            for j in range(n):
                if mat[i][j]:
                    state |= 1 << (i * n + j)

        directions = [(-1, 0), (1, 0), (0, -1), (0, 1), (0, 0)]

        visited = set()
        queue = deque()
        queue.append((state, 0))
        visited.add(state)

        while queue:
            current, steps = queue.popleft()
            if current == 0:
                return steps
            for i in range(m):
                for j in range(n):
                    next_state = current
                    for dx, dy in directions:
                        x, y = i + dx, j + dy
                        if 0 <= x < m and 0 <= y < n:
                            next_state ^= 1 << (x * n + y)
                    if next_state not in visited:
                        visited.add(next_state)
                        queue.append((next_state, steps + 1))
        return -1