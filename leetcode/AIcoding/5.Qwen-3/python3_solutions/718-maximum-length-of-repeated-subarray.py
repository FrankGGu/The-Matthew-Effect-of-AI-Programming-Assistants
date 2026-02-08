class Solution:
    def maxRepeatedSubarray(self, nums1: List[int], nums2: List[int]) -> int:
        m, n = len(nums1), len(nums2)
        dp = [0] * (n + 1)
        max_len = 0
        for i in range(m):
            for j in range(n, 0, -1):
                if nums1[i] == nums2[j - 1]:
                    dp[j] = dp[j - 1] + 1
                    max_len = max(max_len, dp[j])
                else:
                    dp[j] = 0
        return max_len