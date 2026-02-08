import heapq

class Solution:
    def kthSmallestChair(self, times: List[List[int]], k: int) -> int:
        events = []
        for i, (start, end) in enumerate(times):
            events.append((start, 'arrive', i))
            events.append((end, 'leave', i))

        events.sort()

        available = []
        chairs = [0] * len(times)
        current_chair = 0

        for time, typ, idx in events:
            if typ == 'arrive':
                if available:
                    chair = heapq.heappop(available)
                else:
                    chair = current_chair
                    current_chair += 1
                chairs[idx] = chair
                if chair == k - 1:
                    return idx
            else:
                heapq.heappush(available, chairs[idx])