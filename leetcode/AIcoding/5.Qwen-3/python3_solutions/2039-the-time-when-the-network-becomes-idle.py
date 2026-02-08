class Solution:
    def maxTime(self, n: int, edges: List[List[int]], patience: int, arrival: int) -> int:
        from collections import defaultdict, deque

        graph = defaultdict(list)
        for u, v in edges:
            graph[u].append(v)
            graph[v].append(u)

        visited = [False] * n
        queue = deque()
        queue.append((0, 0))
        visited[0] = True
        max_depth = 0

        while queue:
            node, depth = queue.popleft()
            max_depth = max(max_depth, depth)
            for neighbor in graph[node]:
                if not visited[neighbor]:
                    visited[neighbor] = True
                    queue.append((neighbor, depth + 1))

        time = 0
        for i in range(1, n):
            depth = 0
            visited = [False] * n
            queue = deque()
            queue.append((i, 0))
            visited[i] = True
            while queue:
                node, d = queue.popleft()
                depth = max(depth, d)
                for neighbor in graph[node]:
                    if not visited[neighbor]:
                        visited[neighbor] = True
                        queue.append((neighbor, d + 1))
            round_trip = 2 * depth
            if round_trip % patience == 0:
                t = (round_trip // patience) * patience
            else:
                t = (round_trip // patience + 1) * patience
            time = max(time, t + arrival)

        return time