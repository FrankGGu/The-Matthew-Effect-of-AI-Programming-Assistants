class Solution:
    def minTimeToCollectAllApples(self, n: int, edges: List[List[int]], apples: List[bool]) -> int:
        from collections import defaultdict

        tree = defaultdict(list)
        for u, v in edges:
            tree[u].append(v)
            tree[v].append(u)

        def dfs(node, parent):
            time = 0
            for child in tree[node]:
                if child != parent:
                    child_time = dfs(child, node)
                    if child_time > 0 or apples[child]:
                        time += 2 + child_time
            return time

        return dfs(0, -1)