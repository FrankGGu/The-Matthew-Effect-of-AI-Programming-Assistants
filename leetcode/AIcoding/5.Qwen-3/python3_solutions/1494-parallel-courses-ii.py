class Solution:
    def minNumberOfSemesters(self, n: int, dependencies: List[List[int]], courses: List[int]) -> int:
        from collections import defaultdict, deque

        graph = defaultdict(list)
        in_degree = [0] * n
        for course, prerequisite in dependencies:
            graph[prerequisite - 1].append(course - 1)
            in_degree[course - 1] += 1

        def get_mask(node):
            return 1 << node

        def count_ones(mask):
            return bin(mask).count('1')

        memo = {}

        def dp(mask):
            if mask in memo:
                return memo[mask]
            if mask == (1 << n) - 1:
                return 0
            res = float('inf')
            available = []
            for i in range(n):
                if not (mask & get_mask(i)) and in_degree[i] == 0:
                    available.append(i)
            for subset in subsets(available):
                new_mask = mask
                for node in subset:
                    new_mask |= get_mask(node)
                for node in subset:
                    for neighbor in graph[node]:
                        in_degree[neighbor] -= 1
                res = min(res, 1 + dp(new_mask))
                for node in subset:
                    for neighbor in graph[node]:
                        in_degree[neighbor] += 1
            memo[mask] = res
            return res

        def subsets(arr):
            n = len(arr)
            for mask in range(1, 1 << n):
                subset = []
                for i in range(n):
                    if mask & (1 << i):
                        subset.append(arr[i])
                yield subset

        return dp(0)