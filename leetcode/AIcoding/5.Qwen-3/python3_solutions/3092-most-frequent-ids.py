from collections import defaultdict
import heapq

class Solution:
    def mostFrequent(self, ids: List[int], k: int) -> List[int]:
        count = defaultdict(int)
        max_heap = []

        for id in ids:
            count[id] += 1

        for key, val in count.items():
            heapq.heappush(max_heap, (-val, key))

        result = []
        for _ in range(k):
            if not max_heap:
                break
            freq, num = heapq.heappop(max_heap)
            result.append(num)

        return result