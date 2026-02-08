from collections import deque

class Solution:
    def minReorder(self, n: int, connections: List[List[int]]) -> int:
        graph = [[] for _ in range(n)]
        for u, v in connections:
            graph[u].append((v, 1))
            graph[v].append((u, 0))

        visited = [False] * n
        queue = deque()
        queue.append(0)
        visited[0] = True
        count = 0

        while queue:
            node = queue.popleft()
            for neighbor, direction in graph[node]:
                if not visited[neighbor]:
                    visited[neighbor] = True
                    count += direction
                    queue.append(neighbor)

        return count