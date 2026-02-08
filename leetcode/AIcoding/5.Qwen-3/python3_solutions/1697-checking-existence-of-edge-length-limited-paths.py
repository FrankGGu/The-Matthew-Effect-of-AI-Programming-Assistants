class Solution:
    def distanceLimitedPathsExist(self, n: int, queries: List[List[int]], edges: List[List[int]]) -> List[bool]:
        from collections import defaultdict

        edges.sort(key=lambda x: x[2])
        queries.sort(key=lambda x: x[2])

        parent = list(range(n))

        def find(u):
            while parent[u] != u:
                parent[u] = parent[parent[u]]
                u = parent[u]
            return u

        def union(u, v):
            pu, pv = find(u), find(v)
            if pu == pv:
                return False
            parent[pv] = pu
            return True

        res = [False] * len(queries)
        edge_idx = 0

        for q in queries:
            u, v, limit = q
            while edge_idx < len(edges) and edges[edge_idx][2] < limit:
                a, b, _ = edges[edge_idx]
                union(a, b)
                edge_idx += 1
            res[q[3]] = find(u) == find(v)

        return res