from typing import List

class Solution:
    def getMinCount(self, arr: List[int]) -> int:
        n = len(arr)
        dp = [0] * n
        for i in range(1, n):
            if arr[i] > arr[i - 1]:
                dp[i] = dp[i - 1]
            else:
                dp[i] = dp[i - 1] + 1
        return dp[-1]