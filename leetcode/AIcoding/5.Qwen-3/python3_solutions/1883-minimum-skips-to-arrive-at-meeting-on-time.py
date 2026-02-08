from typing import List
import math

class Solution:
    def minSkipsToArriveOnTime(self, dist: List[int], hour: float) -> int:
        n = len(dist)
        if hour < 0.00001:
            return -1
        dp = [float('inf')] * (n + 1)
        dp[0] = 0
        for i in range(n):
            new_dp = [float('inf')] * (n + 1)
            for j in range(i + 1):
                if dp[j] == float('inf'):
                    continue
                time = dp[j] + dist[i] / 60
                if j == i:
                    new_dp[j] = min(new_dp[j], time)
                else:
                    new_dp[j + 1] = min(new_dp[j + 1], time)
            dp = new_dp
        for i in range(n + 1):
            if dp[i] <= hour:
                return i
        return -1