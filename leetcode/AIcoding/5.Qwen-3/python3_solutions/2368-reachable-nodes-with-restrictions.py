class Solution:
    def reachableNodes(self, n: int, edges: List[List[int]], restricted: List[int]) -> int:
        from collections import deque

        graph = [[] for _ in range(n)]
        for u, v in edges:
            graph[u].append(v)
            graph[v].append(u)

        restricted_set = set(restricted)
        visited = [False] * n
        queue = deque()
        count = 0

        for i in range(n):
            if i not in restricted_set:
                queue.append(i)
                visited[i] = True
                break

        while queue:
            node = queue.popleft()
            count += 1
            for neighbor in graph[node]:
                if not visited[neighbor] and neighbor not in restricted_set:
                    visited[neighbor] = True
                    queue.append(neighbor)

        return count