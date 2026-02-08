from typing import List
import heapq

class Solution:
    def minimumCostToHome(self, x: int, y: int, specialRoads: List[List[int]]) -> int:
        graph = {}

        def addEdge(u, v, cost):
            if u not in graph:
                graph[u] = []
            graph[u].append((v, cost))

        for road in specialRoads:
            x1, y1, x2, y2, cost = road
            addEdge((x1, y1), (x2, y2), cost)
            addEdge((x2, y2), (x1, y1), cost)

        heap = [(0, 0, 0)]
        visited = set()

        while heap:
            dist, curr_x, curr_y = heapq.heappop(heap)
            if (curr_x, curr_y) in visited:
                continue
            visited.add((curr_x, curr_y))
            if curr_x == x and curr_y == y:
                return dist
            for dx, dy in [(1, 0), (-1, 0), (0, 1), (0, -1)]:
                nx, ny = curr_x + dx, curr_y + dy
                if (nx, ny) not in visited:
                    heapq.heappush(heap, (dist + 1, nx, ny))
            if (curr_x, curr_y) in graph:
                for neighbor, cost in graph[(curr_x, curr_y)]:
                    if neighbor not in visited:
                        heapq.heappush(heap, (dist + cost, neighbor[0], neighbor[1]))
        return -1