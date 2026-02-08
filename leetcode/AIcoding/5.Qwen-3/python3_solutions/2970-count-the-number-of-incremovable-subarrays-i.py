from typing import List

class Solution:
    def numberOfSubarrays(self, nums: List[int]) -> int:
        n = len(nums)
        res = 0
        for i in range(n):
            j = i
            while j < n and nums[j] >= nums[i]:
                j += 1
            res += j - i
        return res