class Solution:
    def maxSpending(self, days: List[List[int]]) -> int:
        from heapq import heappush, heappop
        heap = []
        for day in days:
            for price in day:
                heappush(heap, price)
        total = 0
        while heap:
            total += heappop(heap)
        return total