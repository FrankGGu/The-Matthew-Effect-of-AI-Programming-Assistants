class Solution:
    def gcdSort(self, nums: list[int]) -> bool:
        from math import gcd
        from collections import defaultdict

        max_num = max(nums)
        parent = list(range(max_num + 1))

        def find(x):
            if parent[x] != x:
                parent[x] = find(parent[x])
            return parent[x]

        def union(x, y):
            px = find(x)
            py = find(y)
            if px != py:
                parent[px] = py

        for i in range(2, max_num + 1):
            for j in range(i * 2, max_num + 1, i):
                union(i, j)

        groups = defaultdict(set)
        for num in nums:
            groups[find(num)].add(num)

        for group in groups.values():
            if len(group) > 1:
                sorted_group = sorted(group)
                for i in range(1, len(sorted_group)):
                    if find(sorted_group[i]) != find(sorted_group[i - 1]):
                        return False
        return True