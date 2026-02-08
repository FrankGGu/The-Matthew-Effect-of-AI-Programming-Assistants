class Solution:
    def countPalindromePaths(self, tree: List[List[int]]) -> int:
        from collections import defaultdict

        def dfs(node, path):
            path ^= (1 << (ord(tree[node][0]) - ord('a')))
            count[path] += 1
            for child in tree[node][1:]:
                dfs(child, path)

        count = defaultdict(int)
        dfs(0, 0)
        res = 0
        for c in count.values():
            res += c * (c - 1) // 2
        return res