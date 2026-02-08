class Solution:
    def isPossibleToCatchApple(self, n: int, edges: List[List[int]], time: int, person: int, apple: int) -> bool:
        from collections import defaultdict, deque

        graph = defaultdict(list)
        for u, v in edges:
            graph[u].append(v)
            graph[v].append(u)

        visited = [False] * n
        queue = deque()
        queue.append((person, 0))
        visited[person] = True

        while queue:
            node, t = queue.popleft()
            if node == apple:
                return t <= time
            if t + 1 > time:
                continue
            for neighbor in graph[node]:
                if not visited[neighbor]:
                    visited[neighbor] = True
                    queue.append((neighbor, t + 1))

        return False