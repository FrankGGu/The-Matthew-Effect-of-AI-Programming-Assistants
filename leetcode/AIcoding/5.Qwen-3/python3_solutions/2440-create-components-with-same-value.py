class Solution:
    def componentValue(self, de: str) -> int:
        from collections import deque

        def dfs(node, visited, graph, values):
            visited.add(node)
            total = values[node]
            for neighbor in graph[node]:
                if neighbor not in visited:
                    total += dfs(neighbor, visited, graph, values)
            return total

        def buildGraph(de):
            graph = {}
            values = {}
            nodes = set()
            parts = de.split(',')
            for part in parts:
                if not part:
                    continue
                node, rest = part.split(':', 1)
                nodes.add(node)
                values[node] = int(rest)
                for neighbor in rest.split(';'):
                    if neighbor:
                        nodes.add(neighbor)
                        if node not in graph:
                            graph[node] = []
                        graph[node].append(neighbor)
            for node in nodes:
                if node not in graph:
                    graph[node] = []
            return graph, values

        graph, values = buildGraph(de)
        nodes = list(values.keys())
        max_val = max(values.values())
        total_sum = sum(values.values())
        for i in range(len(nodes), 0, -1):
            if total_sum % i == 0:
                target = total_sum // i
                visited = set()
                count = 0
                for node in nodes:
                    if node not in visited:
                        s = dfs(node, visited, graph, values)
                        if s == target:
                            count += 1
                if count >= i:
                    return i
        return 0