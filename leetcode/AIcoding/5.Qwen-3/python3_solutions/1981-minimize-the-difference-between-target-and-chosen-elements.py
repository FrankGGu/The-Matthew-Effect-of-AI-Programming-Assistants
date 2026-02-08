from typing import List
import heapq

class Solution:
    def minimizeSum(self, nums: List[int], k: int) -> int:
        nums.sort()
        heap = []
        for i in range(len(nums)):
            heapq.heappush(heap, -nums[i])
        for _ in range(k):
            current = -heapq.heappop(heap)
            current -= 1
            heapq.heappush(heap, -current)
        return max(-x for x in heap)