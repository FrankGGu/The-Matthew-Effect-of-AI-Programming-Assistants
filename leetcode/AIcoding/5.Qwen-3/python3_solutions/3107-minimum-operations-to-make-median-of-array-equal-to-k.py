from typing import List

class Solution:
    def minOperations(self, nums: List[int], k: int) -> int:
        nums.sort()
        n = len(nums)
        mid = n // 2
        res = 0
        for i in range(mid, n):
            if nums[i] < k:
                res += k - nums[i]
            else:
                break
        return res