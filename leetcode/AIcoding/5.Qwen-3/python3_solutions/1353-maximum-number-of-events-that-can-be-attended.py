class Solution:
    def maxEvents(self, events: List[List[int]]) -> int:
        events.sort()
        import heapq
        heap = []
        i = 0
        res = 0
        while i < len(events) or heap:
            if not heap:
                start = events[i][0]
                end = events[i][1]
                heapq.heappush(heap, end)
                i += 1
            else:
                if i < len(events) and events[i][0] <= heap[0]:
                    heapq.heappush(heap, events[i][1])
                    i += 1
                else:
                    heapq.heappop(heap)
                    res += 1
        return res