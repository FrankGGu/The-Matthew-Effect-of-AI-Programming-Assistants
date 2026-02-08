from typing import List

class Solution:
    def minimumSum(self, nums: List[int], k: int, m: int) -> int:
        n = len(nums)
        prefix = [0] * (n + 1)
        for i in range(n):
            prefix[i + 1] = prefix[i] + nums[i]

        min_sum = float('inf')
        for i in range(n - m + 1):
            subarray = nums[i:i + m]
            if len(subarray) < m:
                continue
            total = sum(subarray)
            if total < min_sum:
                min_sum = total

        return min_sum