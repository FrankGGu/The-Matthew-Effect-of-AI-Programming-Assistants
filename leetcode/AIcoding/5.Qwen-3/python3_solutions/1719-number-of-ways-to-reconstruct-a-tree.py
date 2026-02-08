class Solution:
    def waysToReconstructTree(self, n: int, queries: List[List[int]]) -> int:
        from collections import defaultdict

        def dfs(u, parent):
            for v in adj[u]:
                if v != parent:
                    dfs(v, u)
                    cnt[u] += cnt[v]
                    if cnt[v] > 0:
                        res[u] = (res[u] * res[v]) % (10**9 + 7)

        adj = defaultdict(list)
        for u, v in queries:
            adj[u].append(v)
            adj[v].append(u)

        cnt = [0] * (n + 1)
        res = [1] * (n + 1)

        for i in range(1, n + 1):
            cnt[i] = 1

        dfs(1, -1)

        return res[1]