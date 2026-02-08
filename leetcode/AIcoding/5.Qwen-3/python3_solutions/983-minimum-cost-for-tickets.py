class Solution:
    def mincostTickets(self, days: List[int], costs: List[int]) -> int:
        dp = [0] * (len(days) + 1)
        for i in range(1, len(days) + 1):
            day = days[i - 1]
            cost1 = dp[i - 1] + costs[0]
            j = i - 1
            while j >= 0 and days[j] >= day - 6:
                j -= 1
            cost7 = dp[j + 1] + costs[1]
            j = i - 1
            while j >= 0 and days[j] >= day - 29:
                j -= 1
            cost30 = dp[j + 1] + costs[2]
            dp[i] = min(cost1, cost7, cost30)
        return dp[-1]