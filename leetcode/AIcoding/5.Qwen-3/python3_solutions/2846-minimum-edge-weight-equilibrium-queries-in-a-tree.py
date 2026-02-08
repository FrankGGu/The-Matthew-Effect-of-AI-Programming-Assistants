class Solution:
    def findEquilibriumQueries(self, n: int, edges: List[List[int]], queries: List[int]) -> List[int]:
        from collections import defaultdict

        tree = defaultdict(list)
        for u, v in edges:
            tree[u].append(v)
            tree[v].append(u)

        size = [0] * (n + 1)

        def dfs(u, parent):
            size[u] = 1
            for v in tree[u]:
                if v != parent:
                    dfs(v, u)
                    size[u] += size[v]

        dfs(1, -1)

        result = []

        for q in queries:
            found = False
            for u in range(1, n + 1):
                total = size[u]
                for v in tree[u]:
                    if size[v] == q and total - size[v] == q:
                        result.append(u)
                        found = True
                        break
                if found:
                    break
            if not found:
                result.append(-1)

        return result