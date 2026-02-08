from typing import List
import heapq

class Solution:
    def avoidFlood(self, rains: List[int]) -> List[str]:
        lake = {}
        heap = []
        res = [""] * len(rains)

        for i, lake_name in enumerate(rains):
            if lake_name == 0:
                res[i] = "Do nothing"
                continue
            if lake_name in lake:
                idx = lake[lake_name]
                while heap and heap[0] < idx:
                    heapq.heappop(heap)
                if not heap:
                    return []
                res[heapq.heappop(heap)] = "Do nothing"
                res[i] = "Do nothing"
            else:
                res[i] = "Do nothing"
            lake[lake_name] = i
            heapq.heappush(heap, i)

        for i in range(len(rains)):
            if res[i] == "":
                res[i] = "Do nothing"

        return res