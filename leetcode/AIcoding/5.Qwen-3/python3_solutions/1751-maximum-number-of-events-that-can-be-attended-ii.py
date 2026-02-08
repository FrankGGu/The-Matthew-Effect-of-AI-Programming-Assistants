class Solution:
    def maxEvents(self, startTime: List[int], endTime: List[int]) -> int:
        events = sorted(zip(startTime, endTime))
        n = len(events)
        dp = [0] * (n + 1)

        for i in range(n - 1, -1, -1):
            j = i + 1
            while j < n and events[j][0] <= events[i][1]:
                j += 1
            dp[i] = max(dp[i + 1], dp[j] + 1)

        return dp[0]