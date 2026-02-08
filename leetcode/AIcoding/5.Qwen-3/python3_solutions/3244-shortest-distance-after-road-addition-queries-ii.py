from typing import List
import heapq

class Solution:
    def shortestDistance(self, n: int, roads: List[List[int]]) -> List[int]:
        graph = [[] for _ in range(n)]
        for u, v in roads:
            graph[u].append(v)
            graph[v].append(u)

        result = [0] * n
        dist = [-1] * n
        dist[0] = 0
        heap = [(0, 0)]

        while heap:
            d, u = heapq.heappop(heap)
            if d > dist[u]:
                continue
            for v in graph[u]:
                if dist[v] == -1 or d + 1 < dist[v]:
                    dist[v] = d + 1
                    heapq.heappush(heap, (d + 1, v))

        for i in range(n):
            result[i] = dist[i]

        return result