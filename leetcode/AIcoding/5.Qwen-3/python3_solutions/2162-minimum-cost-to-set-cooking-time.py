class Solution:
    def minTimeToCook(self, time: List[int], multiple: int) -> int:
        import heapq
        heap = time[:]
        heapq.heapify(heap)
        for _ in range(multiple):
            val = heapq.heappop(heap)
            heapq.heappush(heap, val * 2)
        return sum(heap)