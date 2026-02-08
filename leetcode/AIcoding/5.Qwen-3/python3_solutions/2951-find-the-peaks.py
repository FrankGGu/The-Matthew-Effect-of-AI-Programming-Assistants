from typing import List

class Solution:
    def isPeak(self, nums: List[int], index: int) -> bool:
        if index == 0 or index == len(nums) - 1:
            return False
        return nums[index] > nums[index - 1] and nums[index] > nums[index + 1]

    def findPeaks(self, nums: List[int]) -> List[int]:
        peaks = []
        for i in range(1, len(nums) - 1):
            if self.isPeak(nums, i):
                peaks.append(i)
        return peaks