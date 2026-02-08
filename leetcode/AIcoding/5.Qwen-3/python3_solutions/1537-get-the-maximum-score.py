class Solution:
    def maxSum(self, nums1: List[int], nums2: List[int]) -> int:
        MOD = 10**9 + 7
        i = j = 0
        sum1 = sum2 = 0
        while i < len(nums1) and j < len(nums2):
            if nums1[i] < nums2[j]:
                sum1 += nums1[i]
                i += 1
            elif nums1[i] > nums2[j]:
                sum2 += nums2[j]
                j += 1
            else:
                sum1 += nums1[i]
                sum2 += nums2[j]
                i += 1
                j += 1
        while i < len(nums1):
            sum1 += nums1[i]
            i += 1
        while j < len(nums2):
            sum2 += nums2[j]
            j += 1
        return max(sum1, sum2) % MOD