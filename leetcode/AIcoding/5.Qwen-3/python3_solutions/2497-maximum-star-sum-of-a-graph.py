class Solution:
    def maximumStarSum(self, vals: List[int], edges: List[List[int]]) -> int:
        from collections import defaultdict

        graph = defaultdict(list)
        for u, v in edges:
            graph[u].append(v)
            graph[v].append(u)

        max_sum = 0
        visited = set()

        def dfs(node):
            if node in visited:
                return 0
            visited.add(node)
            total = vals[node]
            for neighbor in graph[node]:
                total += dfs(neighbor)
            return total

        for i in range(len(vals)):
            if i not in visited:
                current_sum = dfs(i)
                max_sum = max(max_sum, current_sum)

        return max_sum