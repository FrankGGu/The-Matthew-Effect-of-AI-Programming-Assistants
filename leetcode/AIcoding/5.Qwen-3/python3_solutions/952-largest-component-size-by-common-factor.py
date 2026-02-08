class Solution:
    def largestComponentSize(self, nums: List[int]) -> int:
        from collections import defaultdict

        def find(x):
            if parent[x] != x:
                parent[x] = find(parent[x])
            return parent[x]

        def union(x, y):
            px, py = find(x), find(y)
            if px != py:
                parent[px] = py

        max_num = max(nums)
        parent = list(range(max_num + 1))

        for num in nums:
            i = 2
            while i * i <= num:
                if num % i == 0:
                    union(num, i)
                    union(num, num // i)
                i += 1

        count = defaultdict(int)
        max_size = 0
        for num in nums:
            root = find(num)
            count[root] += 1
            max_size = max(max_size, count[root])

        return max_size