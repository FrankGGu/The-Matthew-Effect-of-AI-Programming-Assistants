class Solution:
    def calcEquation(self, equations: List[List[str]], values: List[float], queries: List[List[str]]) -> List[float]:
        from collections import defaultdict, deque

        graph = defaultdict(dict)

        for (a, b), val in zip(equations, values):
            graph[a][b] = val
            graph[b][a] = 1.0 / val

        def bfs(start, end):
            if start not in graph or end not in graph:
                return -1.0
            visited = set()
            queue = deque([(start, 1.0)])
            while queue:
                node, curr_val = queue.popleft()
                if node == end:
                    return curr_val
                visited.add(node)
                for neighbor, weight in graph[node].items():
                    if neighbor not in visited:
                        queue.append((neighbor, curr_val * weight))
            return -1.0

        result = []
        for a, b in queries:
            result.append(bfs(a, b))
        return result