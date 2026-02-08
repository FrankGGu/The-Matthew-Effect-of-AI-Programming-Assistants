class Solution:
    def getKthAncestor(self, node: int, k: int) -> int:
        from collections import defaultdict

        def dfs(u):
            for v in tree[u]:
                depth[v] = depth[u] + 1
                parent[v][0] = u
                dfs(v)

        tree = defaultdict(list)
        for i in range(1, len(parents)):
            tree[parents[i]].append(i)

        max_level = k.bit_length()
        parent = [[-1] * max_level for _ in range(len(parents))]
        depth = [0] * len(parents)

        dfs(0)

        for j in range(1, max_level):
            for i in range(len(parents)):
                if parent[i][j - 1] != -1:
                    parent[i][j] = parent[parent[i][j - 1]][j - 1]

        res = node
        for j in range(max_level):
            if k & (1 << j):
                res = parent[res][j]
                if res == -1:
                    return -1
        return res