from typing import List
import heapq

class Solution:
    def minTimeToMakeArraySumAtMost(self, target: int, arr: List[int]) -> int:
        max_heap = []
        total = sum(arr)
        if total <= target:
            return 0
        for num in arr:
            heapq.heappush(max_heap, -num)
        time = 0
        while total > target:
            current = -heapq.heappop(max_heap)
            total -= current
            current //= 2
            total += current
            heapq.heappush(max_heap, -current)
            time += 1
        return time