from collections import deque

class Solution:
    def findShortestCycle(self, n: int, edges: List[List[int]]) -> int:
        graph = [[] for _ in range(n)]
        for u, v in edges:
            graph[u].append(v)
            graph[v].append(u)

        min_cycle = float('inf')

        for start in range(n):
            visited = [-1] * n
            queue = deque()
            queue.append(start)
            visited[start] = 0

            while queue:
                node = queue.popleft()
                for neighbor in graph[node]:
                    if visited[neighbor] == -1:
                        visited[neighbor] = visited[node] + 1
                        queue.append(neighbor)
                    else:
                        if visited[neighbor] < visited[node]:
                            min_cycle = min(min_cycle, visited[node] + visited[neighbor] + 1)

        return min_cycle if min_cycle != float('inf') else -1