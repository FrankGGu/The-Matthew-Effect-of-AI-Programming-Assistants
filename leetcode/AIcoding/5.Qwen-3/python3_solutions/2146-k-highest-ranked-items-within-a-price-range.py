from collections import deque
import heapq

class Solution:
    def highestRankedKItemsBetweenPriceRange(self, grid: List[List[int]], priceRange: List[int], k: int) -> List[List[int]]:
        rows, cols = len(grid), len(grid[0])
        minPrice, maxPrice = priceRange
        directions = [(-1, 0), (1, 0), (0, -1), (0, 1)]
        queue = deque()
        result = []

        for i in range(rows):
            for j in range(cols):
                if minPrice <= grid[i][j] <= maxPrice:
                    queue.append((i, j, 0))

        while queue:
            x, y, dist = queue.popleft()
            result.append((dist, grid[x][y], x, y))
            for dx, dy in directions:
                nx, ny = x + dx, y + dy
                if 0 <= nx < rows and 0 <= ny < cols and grid[nx][ny] >= minPrice and grid[nx][ny] <= maxPrice:
                    queue.append((nx, ny, dist + 1))

        result.sort()
        return [[x, y] for _, _, x, y in result[:k]]