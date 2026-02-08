from typing import List

class Solution:
    def kthSmallestPrimeFraction(self, sortedList: List[int], k: int) -> List[int]:
        import heapq

        heap = []
        n = len(sortedList)
        for i in range(n):
            heapq.heappush(heap, (sortedList[i] / sortedList[-1], i, n - 1))

        for _ in range(k - 1):
            val, i, j = heapq.heappop(heap)
            if j - 1 > i:
                heapq.heappush(heap, (sortedList[i] / sortedList[j - 1], i, j - 1))

        val, i, j = heapq.heappop(heap)
        return [sortedList[i], sortedList[j]]