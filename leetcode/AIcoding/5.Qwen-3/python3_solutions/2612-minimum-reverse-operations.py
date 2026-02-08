from collections import deque

class Solution:
    def get_min_reverse_operations(self, n: int, edges: List[List[int]]) -> List[int]:
        graph = [[] for _ in range(n)]
        for u, v in edges:
            graph[u].append(v)
            graph[v].append(u)

        dist = [-1] * n
        q = deque()
        for i in range(n):
            if len(graph[i]) == 0:
                dist[i] = 0
                q.append(i)

        while q:
            u = q.popleft()
            for v in graph[u]:
                if dist[v] == -1:
                    dist[v] = dist[u] + 1
                    q.append(v)

        return dist