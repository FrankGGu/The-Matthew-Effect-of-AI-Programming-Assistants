class Solution:
    def minAbsoluteSumDiff(self, nums1: List[int], nums2: List[int]) -> int:
        import bisect
        n = len(nums1)
        sorted_nums1 = sorted(nums1)
        min_diff = float('inf')
        for i in range(n):
            diff = abs(nums1[i] - nums2[i])
            if diff < min_diff:
                min_diff = diff
            idx = bisect.bisect_left(sorted_nums1, nums2[i])
            if idx < n:
                min_diff = min(min_diff, abs(sorted_nums1[idx] - nums2[i]))
            if idx > 0:
                min_diff = min(min_diff, abs(sorted_nums1[idx - 1] - nums2[i]))
        return min_diff