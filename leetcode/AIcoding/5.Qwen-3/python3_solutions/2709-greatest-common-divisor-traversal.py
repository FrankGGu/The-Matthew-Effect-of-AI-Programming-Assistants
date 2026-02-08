class Solution:
    def largestComponentSize(self, nums: List[int]) -> int:
        from collections import defaultdict, Counter

        def find(x):
            while parent[x] != x:
                parent[x] = parent[parent[x]]
                x = parent[x]
            return x

        def union(x, y):
            root_x = find(x)
            root_y = find(y)
            if root_x != root_y:
                parent[root_x] = root_y

        max_num = max(nums)
        parent = list(range(max_num + 1))

        for num in nums:
            i = 2
            while i * i <= num:
                if num % i == 0:
                    union(num, i)
                    union(num, num // i)
                i += 1

        count = Counter()
        for num in nums:
            root = find(num)
            count[root] += 1

        return max(count.values()) if count else 0