from typing import List
import heapq

class Solution:
    def minTimeToBreakLocks(self, locks: List[int], keys: List[int], time: int) -> int:
        pq = []
        for key in keys:
            heapq.heappush(pq, (0, key))

        visited = set()
        while pq:
            current_time, key = heapq.heappop(pq)
            if key in visited:
                continue
            visited.add(key)
            if len(visited) == len(keys):
                return current_time
            for lock in locks:
                if lock % key == 0:
                    new_time = current_time + time
                    heapq.heappush(pq, (new_time, lock))

        return -1