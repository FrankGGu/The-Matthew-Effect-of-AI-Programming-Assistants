from typing import List
import heapq

class Solution:
    def maxKEdge(self, n: int, edges: List[List[int]], k: int) -> int:
        graph = [[] for _ in range(n)]
        for u, v, w in edges:
            graph[u].append((v, w))
            graph[v].append((u, w))

        max_heap = []
        visited = [False] * n

        def dfs(node, path_weight, depth):
            if depth == k:
                heapq.heappush(max_heap, -path_weight)
                return
            visited[node] = True
            for neighbor, weight in graph[node]:
                if not visited[neighbor]:
                    dfs(neighbor, path_weight + weight, depth + 1)
            visited[node] = False

        for i in range(n):
            dfs(i, 0, 0)

        return -max_heap[0]