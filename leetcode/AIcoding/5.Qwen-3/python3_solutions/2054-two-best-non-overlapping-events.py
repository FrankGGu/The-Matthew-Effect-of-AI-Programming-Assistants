from typing import List
import bisect

class Solution:
    def maxTwoEvents(self, events: List[List[int]]) -> int:
        events.sort()
        n = len(events)
        end_times = [event[1] for event in events]
        max_events = [0] * n
        max_so_far = 0
        for i in range(n - 1, -1, -1):
            max_so_far = max(max_so_far, events[i][2])
            max_events[i] = max_so_far
        res = 0
        for i in range(n):
            res = max(res, events[i][2])
            j = bisect.bisect_right(end_times, events[i][1])
            if j < n:
                res = max(res, events[i][2] + max_events[j])
        return res