class Solution:
    def longestPath(self, nums: List[int]) -> int:
        from collections import defaultdict, deque

        graph = defaultdict(list)
        n = len(nums)
        for i in range(n):
            left = 2 * i + 1
            right = 2 * i + 2
            if left < n:
                graph[i].append(left)
            if right < n:
                graph[i].append(right)

        max_len = [0]
        def dfs(node):
            if not graph[node]:
                return 1
            res = 0
            for neighbor in graph[node]:
                res = max(res, dfs(neighbor))
            max_len[0] = max(max_len[0], res + 1)
            return res + 1

        dfs(0)
        return max_len[0]