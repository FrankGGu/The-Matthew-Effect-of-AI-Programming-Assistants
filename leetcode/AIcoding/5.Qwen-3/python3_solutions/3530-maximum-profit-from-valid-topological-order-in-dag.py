from typing import List
from collections import defaultdict, deque

class Solution:
    def maxProfit(self, n: int, edges: List[List[int]], prices: List[int], profit: List[int]) -> int:
        graph = defaultdict(list)
        in_degree = [0] * n
        for u, v in edges:
            graph[u].append(v)
            in_degree[v] += 1

        queue = deque()
        for i in range(n):
            if in_degree[i] == 0:
                queue.append(i)

        dp = [0] * n
        while queue:
            u = queue.popleft()
            for v in graph[u]:
                dp[v] = max(dp[v], dp[u] + profit[v])
                in_degree[v] -= 1
                if in_degree[v] == 0:
                    queue.append(v)

        return max(dp)