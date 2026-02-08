import heapq

class Solution:
    def removeStones(self, piles: List[int], k: int) -> int:
        max_heap = [-x for x in piles]
        heapq.heapify(max_heap)

        while k > 0:
            current = -heapq.heappop(max_heap)
            if current <= 0:
                break
            current -= 1
            heapq.heappush(max_heap, -current)
            k -= 1

        return -sum(max_heap)