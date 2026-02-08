from typing import List

class Solution:
    def numberOfSubarrays(self, nums: List[int]) -> int:
        n = len(nums)
        left = 0
        right = n - 1
        while left < n and nums[left] <= nums[left + 1]:
            left += 1
        if left == n - 1:
            return n * (n + 1) // 2
        while right >= 0 and nums[right] >= nums[right - 1]:
            right -= 1
        res = 0
        j = right
        for i in range(left + 1):
            while j < n and nums[j] >= nums[i]:
                j += 1
            res += n - j + 1
        return res