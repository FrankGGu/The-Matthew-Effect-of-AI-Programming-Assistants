from typing import List

class Solution:
    def maximumTop(self, nums: List[int], k: int) -> int
        n = len(nums)
        if k == 0:
            return nums[0]
        if n == 1:
            return -1 if k % 2 == 0 else nums[0]
        if k < n:
            return max(nums[:k])
        elif k == n:
            return max(nums)
        else:
            return max(nums)