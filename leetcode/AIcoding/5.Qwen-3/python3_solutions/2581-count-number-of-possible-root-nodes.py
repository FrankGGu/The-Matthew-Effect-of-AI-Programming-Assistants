class Solution:
    def possibleRootNodes(self, edges: List[List[int]]) -> int:
        from collections import defaultdict

        graph = defaultdict(set)
        for u, v in edges:
            graph[u].add(v)
            graph[v].add(u)

        visited = set()

        def dfs(node):
            visited.add(node)
            for neighbor in graph[node]:
                if neighbor not in visited:
                    dfs(neighbor)

        count = 0
        for node in graph:
            if node not in visited:
                dfs(node)
                count += 1

        return count