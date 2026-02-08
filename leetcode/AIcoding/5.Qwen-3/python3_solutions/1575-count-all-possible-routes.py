class Solution:
    def countRoutes(self, roads: List[List[int]], w: int) -> int:
        from collections import defaultdict
        import functools

        graph = defaultdict(list)
        for u, v in roads:
            graph[u].append(v)
            graph[v].append(u)

        @functools.lru_cache(None)
        def dfs(node, fuel):
            res = 0
            if node == w:
                res += 1
            for neighbor in graph[node]:
                if fuel > 0:
                    res += dfs(neighbor, fuel - 1)
            return res

        return dfs(0, w)