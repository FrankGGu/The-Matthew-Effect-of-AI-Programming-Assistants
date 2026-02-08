from typing import List
import heapq

class Solution:
    def kSum(self, nums: List[int], k: int, kth: int) -> int:
        max_heap = []
        for num in nums:
            if len(max_heap) < k:
                heapq.heappush(max_heap, -num)
            else:
                if num < -max_heap[0]:
                    heapq.heappop(max_heap)
                    heapq.heappush(max_heap, -num)
        return -max_heap[0]