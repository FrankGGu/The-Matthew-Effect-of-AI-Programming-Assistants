class Solution:
    def calcEquation(self, equations: List[List[str]], values: List[float], queries: List[List[str]]) -> List[float]:
        from collections import defaultdict, deque

        graph = defaultdict(dict)

        for (a, b), value in zip(equations, values):
            graph[a][b] = value
            graph[b][a] = 1.0 / value

        def bfs(start, end):
            if start not in graph or end not in graph:
                return -1.0
            visited = set()
            queue = deque([(start, 1.0)])
            while queue:
                node, product = queue.popleft()
                if node == end:
                    return product
                visited.add(node)
                for neighbor, weight in graph[node].items():
                    if neighbor not in visited:
                        queue.append((neighbor, product * weight))
            return -1.0

        result = []
        for a, b in queries:
            result.append(bfs(a, b))
        return result