from typing import List
import heapq

class Solution:
    def maxScore(self, nums1: List[int], nums2: List[int], k: int) -> int:
        pairs = list(zip(nums1, nums2))
        pairs.sort(key=lambda x: -x[1])

        min_heap = []
        sum_nums1 = 0
        max_score = 0

        for i in range(len(pairs)):
            nums1_val, nums2_val = pairs[i]
            sum_nums1 += nums1_val
            heapq.heappush(min_heap, nums1_val)

            if i >= k:
                sum_nums1 -= heapq.heappop(min_heap)

            if i >= k - 1:
                max_score = max(max_score, sum_nums1 * nums2_val)

        return max_score