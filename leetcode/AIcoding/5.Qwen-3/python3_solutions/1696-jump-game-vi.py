from collections import deque
from typing import List

class Solution:
    def maxResult(self, nums: List[int], k: int) -> int:
        n = len(nums)
        dp = [0] * n
        dp[0] = nums[0]
        dq = deque()
        dq.append(0)

        for i in range(1, n):
            while dq and dq[0] < i - k:
                dq.popleft()
            dp[i] = nums[i] + dp[dq[0]]
            while dq and dp[i] >= dp[dq[-1]]:
                dq.pop()
            dq.append(i)

        return dp[-1]