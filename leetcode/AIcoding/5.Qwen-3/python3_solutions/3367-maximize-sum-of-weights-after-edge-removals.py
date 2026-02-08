class Solution:
    def maxSumAfterRemovals(self, nums: List[int], edges: List[List[int]]) -> int:
        from collections import defaultdict

        def dfs(u, parent):
            for v in graph[u]:
                if v != parent:
                    dfs(v, u)
                    subtree_sum[u] += subtree_sum[v]
            return

        n = len(nums)
        graph = defaultdict(list)
        for u, v in edges:
            graph[u].append(v)
            graph[v].append(u)

        subtree_sum = [0] * n
        for i in range(n):
            subtree_sum[i] = nums[i]

        dfs(0, -1)

        total_sum = sum(nums)
        max_sum = 0

        for i in range(n):
            for j in range(i + 1, n):
                if subtree_sum[i] == 0 or subtree_sum[j] == 0:
                    continue
                if (total_sum - subtree_sum[i] - subtree_sum[j]) > max_sum:
                    max_sum = total_sum - subtree_sum[i] - subtree_sum[j]

        return max_sum