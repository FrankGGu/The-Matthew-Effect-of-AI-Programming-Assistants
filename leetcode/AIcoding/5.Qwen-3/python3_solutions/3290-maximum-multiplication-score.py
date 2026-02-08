class Solution:
    def maximumMultiplicationScore(self, nums1: List[int], nums2: List[int]) -> int:
        max_score = -inf
        for i in range(len(nums1)):
            score = nums1[i] * nums2[i]
            if score > max_score:
                max_score = score
        return max_score