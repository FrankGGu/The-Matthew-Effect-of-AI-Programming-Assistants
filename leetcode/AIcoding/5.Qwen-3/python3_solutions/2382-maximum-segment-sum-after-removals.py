class Solution:
    def maximumSegmentSum(self, nums: List[int], removeQueries: List[int]) -> List[int]:
        from collections import defaultdict

        n = len(nums)
        parent = list(range(n))
        size = [1] * n

        def find(x):
            while parent[x] != x:
                parent[x] = parent[parent[x]]
                x = parent[x]
            return x

        def union(x, y):
            root_x = find(x)
            root_y = find(y)
            if root_x == root_y:
                return
            if size[root_x] < size[root_y]:
                root_x, root_y = root_y, root_x
            parent[root_y] = root_x
            size[root_x] += size[root_y]

        result = [0] * n
        removed = [False] * n
        sum_map = defaultdict(int)

        for i in range(n - 1, -1, -1):
            removed[i] = True
            current_sum = nums[i]
            if i + 1 < n and removed[i + 1]:
                current_sum += sum_map[find(i + 1)]
                union(i, i + 1)
            if i - 1 >= 0 and removed[i - 1]:
                current_sum += sum_map[find(i - 1)]
                union(i, i - 1)
            sum_map[find(i)] = current_sum
            result[i] = max(result[i + 1] if i < n - 1 else 0, current_sum)

        return result