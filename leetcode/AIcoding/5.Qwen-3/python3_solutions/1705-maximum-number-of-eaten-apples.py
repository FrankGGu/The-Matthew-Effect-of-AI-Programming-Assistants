import heapq

class Solution:
    def maxEating(self, apples: List[int], days: List[int]) -> int:
        heap = []
        i = 0
        res = 0
        while i < len(apples) or heap:
            if i < len(apples) and apples[i] > 0:
                heapq.heappush(heap, (i + days[i], apples[i]))
            while heap and heap[0][0] <= i:
                heapq.heappop(heap)
            if heap:
                res += 1
                heap[0] = (heap[0][0], heap[0][1] - 1)
                if heap[0][1] == 0:
                    heapq.heappop(heap)
            i += 1
        return res