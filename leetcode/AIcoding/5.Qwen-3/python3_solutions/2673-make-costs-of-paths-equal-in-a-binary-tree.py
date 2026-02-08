class Solution:
    def minCost(self, n: int, edges: List[List[int]], coins: List[int]) -> int:
        from collections import defaultdict

        tree = defaultdict(list)
        for u, v in edges:
            tree[u].append(v)
            tree[v].append(u)

        def dfs(node, parent):
            cost = 0
            for child in tree[node]:
                if child != parent:
                    cost += dfs(child, node)
            return cost + (coins[node] // 2)

        return dfs(1, -1)