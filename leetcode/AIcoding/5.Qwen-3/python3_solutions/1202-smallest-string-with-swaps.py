class Solution:
    def smallestStringWithSwaps(self, s: str, pairs: List[List[int]]) -> str:
        from collections import defaultdict

        def find(x):
            while parent[x] != x:
                parent[x] = parent[parent[x]]
                x = parent[x]
            return x

        def union(x, y):
            root_x = find(x)
            root_y = find(y)
            if root_x != root_y:
                parent[root_y] = root_x

        n = len(s)
        parent = list(range(n))
        for u, v in pairs:
            union(u, v)

        groups = defaultdict(list)
        for i in range(n):
            root = find(i)
            groups[root].append(i)

        res = list(s)
        for group in groups.values():
            indices = sorted(group)
            chars = sorted([s[i] for i in indices])
            for i, idx in enumerate(indices):
                res[idx] = chars[i]

        return ''.join(res)