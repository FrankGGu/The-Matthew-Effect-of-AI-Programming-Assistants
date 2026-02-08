from typing import List
import heapq

class Solution:
    def minWeightedSubgraphWithRequiredPaths(self, n: int, edges: List[List[int]], src: int, dst: int, k: int) -> int:
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

        dist_src = dijkstra(src)
        dist_dst = dijkstra(dst)

        min_total = float('inf')
        for i in range(n):
            if dist_src[i] + dist_dst[i] <= k:
                min_total = min(min_total, dist_src[i] + dist_dst[i])

        return min_total if min_total != float('inf') else -1