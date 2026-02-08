from typing import List

class Solution:
    def numberOfPairs(self, nums1: List[int], nums2: List[int]) -> int:
        count = 0
        for i in range(len(nums1)):
            for j in range(i + 1, len(nums1)):
                if nums1[i] - nums1[j] > nums2[i] - nums2[j]:
                    count += 1
        return count