class Solution:
    def minTimeToReachLastRoom(self, corridor: List[int]) -> int:
        from collections import deque

        n = len(corridor)
        dp = [0] * n
        dq = deque()

        for i in range(n):
            while dq and corridor[dq[-1]] <= corridor[i]:
                dq.pop()
            if dq:
                dp[i] = dp[dq[-1]] + 1
            else:
                dp[i] = 0
            dq.append(i)

        return dp[-1]