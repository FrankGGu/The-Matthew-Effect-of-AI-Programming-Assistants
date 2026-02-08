from collections import deque
import heapq

class Solution:
    def constrainedSubsequenceSum(self, nums: List[int], k: int) -> int:
        n = len(nums)
        dp = [0] * n
        dq = deque()

        for i in range(n):
            if dq and dq[0] < i - k:
                dq.popleft()
            prev = dp[dq[0]] if dq else 0
            dp[i] = prev + nums[i]
            while dq and dp[i] >= dp[dq[-1]]:
                dq.pop()
            dq.append(i)

        return max(dp)