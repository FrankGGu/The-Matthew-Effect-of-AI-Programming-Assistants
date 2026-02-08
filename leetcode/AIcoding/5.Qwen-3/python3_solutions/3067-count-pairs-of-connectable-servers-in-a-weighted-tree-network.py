class Solution:
    def countPairs(self, n: int, edges: List[List[int]], k: int) -> int:
        from collections import defaultdict

        tree = defaultdict(list)
        for u, v in edges:
            tree[u].append(v)
            tree[v].append(u)

        result = 0

        def dfs(node, parent):
            nonlocal result
            dist_count = [0] * (k + 1)
            dist_count[0] = 1
            for child in tree[node]:
                if child == parent:
                    continue
                child_dist = dfs(child, node)
                for d in range(k):
                    if dist_count[d]:
                        result += dist_count[d] * child_dist[k - d - 1]
                for d in range(k):
                    if child_dist[d]:
                        dist_count[d + 1] += child_dist[d]
            return dist_count

        dfs(0, -1)
        return result