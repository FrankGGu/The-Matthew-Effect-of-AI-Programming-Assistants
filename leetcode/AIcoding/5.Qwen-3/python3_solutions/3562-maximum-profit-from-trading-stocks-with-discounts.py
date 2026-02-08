class Solution:
    def maxProfit(self, prices: List[int], costs: List[int]) -> int:
        from collections import deque

        n = len(prices)
        res = 0
        q = deque()

        for i in range(n):
            while q and q[0][0] <= prices[i]:
                q.popleft()
            if q:
                res += prices[i] - q[0][1]
            else:
                res += prices[i]
            q.append((prices[i], costs[i]))

        return res