from typing import List
import heapq

class Solution:
    def secondMinimum(self, n: int, edges: List[List[int]], time: int, change: int) -> int:
        graph = [[] for _ in range(n + 1)]
        for u, v in edges:
            graph[u].append(v)
            graph[v].append(u)

        dist1 = [float('inf')] * (n + 1)
        dist2 = [float('inf')] * (n + 1)
        dist1[1] = 0
        heap = [(0, 1)]

        while heap:
            d, node = heapq.heappop(heap)
            if node == n:
                return dist2[n]
            if d > dist2[node]:
                continue
            for neighbor in graph[node]:
                new_d = d + time
                if (new_d < dist1[neighbor]):
                    dist2[neighbor], dist1[neighbor] = dist1[neighbor], new_d
                    heapq.heappush(heap, (new_d, neighbor))
                elif (new_d > dist1[neighbor] and new_d < dist2[neighbor]):
                    dist2[neighbor] = new_d
                    heapq.heappush(heap, (new_d, neighbor))

        return -1