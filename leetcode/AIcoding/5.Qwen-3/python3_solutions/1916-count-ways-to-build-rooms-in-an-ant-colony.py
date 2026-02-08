class Solution:
    def waysToBuildRooms(self, n: int, parent: List[int]) -> int:
        from collections import defaultdict
        import math

        MOD = 10**9 + 7

        tree = defaultdict(list)
        for i in range(1, n):
            tree[parent[i]].append(i)

        def dfs(u):
            res = 1
            total = 0
            for v in tree[u]:
                sub, cnt = dfs(v)
                res = res * sub % MOD
                res = res * pow(math.comb(total + cnt, cnt), 1, MOD) % MOD
                total += cnt
            return res, total + 1

        return dfs(0)[0]