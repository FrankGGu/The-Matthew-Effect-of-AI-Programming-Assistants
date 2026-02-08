class Solution:
    def minimumTime(self, grid: List[str]) -> int:
        from collections import deque
        import heapq

        m, n = len(grid), len(grid[0])
        if grid[0][1] == 'X' and grid[1][0] == 'X':
            return -1

        directions = [(-1, 0), (1, 0), (0, -1), (0, 1)]
        dist = [[float('inf')] * n for _ in range(m)]
        dist[0][0] = 0
        heap = [(0, 0, 0)]

        while heap:
            time, x, y = heapq.heappop(heap)
            if x == m - 1 and y == n - 1:
                return time
            if time > dist[x][y]:
                continue
            for dx, dy in directions:
                nx, ny = x + dx, y + dy
                if 0 <= nx < m and 0 <= ny < n and grid[nx][ny] != 'X':
                    new_time = time + 1
                    if new_time < dist[nx][ny]:
                        dist[nx][ny] = new_time
                        heapq.heappush(heap, (new_time, nx, ny))
        return -1