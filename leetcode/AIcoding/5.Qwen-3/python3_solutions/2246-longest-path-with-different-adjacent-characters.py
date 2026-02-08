class Solution:
    def longestPath(self, s: str, parent: List[int]) -> int:
        from collections import defaultdict

        tree = defaultdict(list)
        for i in range(1, len(parent)):
            tree[parent[i]].append(i)

        self.result = 0

        def dfs(node):
            max1 = 0
            max2 = 0
            for child in tree[node]:
                length = dfs(child)
                if length > max1:
                    max2 = max1
                    max1 = length
                elif length > max2:
                    max2 = length
            self.result = max(self.result, max1 + max2 + 1)
            return max1 + 1

        dfs(0)
        return self.result