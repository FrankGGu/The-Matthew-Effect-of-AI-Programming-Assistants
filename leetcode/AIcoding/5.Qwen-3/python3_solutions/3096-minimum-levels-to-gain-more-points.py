class Solution:
    def minLevels(self, n: int, roads: List[List[int]]) -> int:
        from collections import defaultdict

        graph = defaultdict(list)
        for u, v in roads:
            graph[u].append(v)
            graph[v].append(u)

        def dfs(node, parent):
            total = 1
            for neighbor in graph[node]:
                if neighbor != parent:
                    total += dfs(neighbor, node)
            return total

        def countPoints(node, parent):
            points = 0
            for neighbor in graph[node]:
                if neighbor != parent:
                    points += countPoints(neighbor, node)
            return points

        total_nodes = dfs(1, -1)
        points = countPoints(1, -1)
        return total_nodes - points