from typing import List
import heapq

class Solution:
    def minimumDifference(self, nums: List[int]) -> int:
        n = len(nums)
        left = [0] * n
        right = [0] * n

        max_heap = []
        total = 0
        for i in range(n):
            heapq.heappush(max_heap, -nums[i])
            total += nums[i]
            if len(max_heap) > (i + 1) // 2:
                removed = -heapq.heappop(max_heap)
                total -= removed
            left[i] = total

        max_heap = []
        total = 0
        for i in range(n - 1, -1, -1):
            heapq.heappush(max_heap, -nums[i])
            total += nums[i]
            if len(max_heap) > (n - i) // 2:
                removed = -heapq.heappop(max_heap)
                total -= removed
            right[i] = total

        result = float('inf')
        for i in range(n - 1):
            result = min(result, abs(left[i] - right[i + 1]))
        return result