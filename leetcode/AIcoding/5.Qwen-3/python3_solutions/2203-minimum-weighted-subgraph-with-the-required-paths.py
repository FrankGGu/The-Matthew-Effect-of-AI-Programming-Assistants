from typing import List
import heapq

class Solution:
    def minWeightedSubgraph(self, n: int, edges: List[List[int]], start1: int, end1: int, start2: int, end2: int) -> int:
        graph = [[] for _ in range(n)]
        for u, v, w in edges:
            graph[u].append((v, w))
            graph[v].append((u, w))

        def dijkstra(start):
            dist = [float('inf')] * n
            dist[start] = 0
            heap = [(0, start)]
            while heap:
                d, u = heapq.heappop(heap)
                if d > dist[u]:
                    continue
                for v, w in graph[u]:
                    if dist[v] > d + w:
                        dist[v] = d + w
                        heapq.heappush(heap, (dist[v], v))
            return dist

        dist1 = dijkstra(start1)
        dist2 = dijkstra(start2)
        dist3 = dijkstra(end1)
        dist4 = dijkstra(end2)

        min_total = float('inf')
        for i in range(n):
            total = dist1[i] + dist2[i] + dist3[i] + dist4[i]
            if total < min_total:
                min_total = total

        return min_total