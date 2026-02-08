from typing import List
import heapq

class Solution:
    def maximumScore(self, n: int, edges: List[List[int]]) -> int:
        graph = [[] for _ in range(n)]
        for u, v in edges:
            graph[u].append(v)
            graph[v].append(u)

        max_heap = []
        for i in range(n):
            if len(graph[i]) < 2:
                continue
            neighbors = graph[i]
            scores = []
            for neighbor in neighbors:
                scores.append(len(graph[neighbor]))
            scores.sort(reverse=True)
            if len(scores) >= 2:
                heapq.heappush(max_heap, -scores[0] * -scores[1])

        return -max_heap[0] if max_heap else -1