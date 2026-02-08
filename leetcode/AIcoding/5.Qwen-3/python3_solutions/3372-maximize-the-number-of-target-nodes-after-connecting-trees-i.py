class Solution:
    def connectTrees(self, n: int, edges: List[List[int]], target: int) -> int:
        from collections import defaultdict, deque

        graph = defaultdict(list)
        for u, v in edges:
            graph[u].append(v)
            graph[v].append(u)

        visited = [False] * (n + 1)
        queue = deque()
        queue.append(target)
        visited[target] = True
        count = 0

        while queue:
            node = queue.popleft()
            count += 1
            for neighbor in graph[node]:
                if not visited[neighbor]:
                    visited[neighbor] = True
                    queue.append(neighbor)

        return count