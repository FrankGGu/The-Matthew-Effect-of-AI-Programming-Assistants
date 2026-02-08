from bisect import bisect_right

class Solution:
    def jobScheduling(self, startTime: List[int], endTime: List[int], profit: List[int]) -> int:
        jobs = sorted(zip(startTime, endTime, profit), key=lambda x: x[1])
        n = len(jobs)
        endTimes = [job[1] for job in jobs]
        dp = [0] * (n + 1)

        for i in range(n):
            start, end, profit = jobs[i]
            j = bisect_right(endTimes, start)
            dp[i + 1] = max(dp[i], dp[j] + profit)

        return dp[n]