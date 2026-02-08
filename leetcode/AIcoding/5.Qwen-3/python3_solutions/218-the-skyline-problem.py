from typing import List
import heapq

class Solution:
    def getSkyline(self, buildings: List[List[int]]) -> List[List[int]]:
        events = []
        for left, right, height in buildings:
            events.append((left, -height, right))
            events.append((right, 0, 0))

        events.sort()

        result = []
        heap = [0]
        prev_height = 0

        for x, h, r in events:
            if h < 0:
                heapq.heappush(heap, h)
            else:
                while heap[0] != 0 and heap[0] != h:
                    heapq.heappop(heap)
                if heap[0] == h:
                    heapq.heappop(heap)

            current_height = -heap[0]
            if current_height != prev_height:
                result.append([x, current_height])
                prev_height = current_height

        return result