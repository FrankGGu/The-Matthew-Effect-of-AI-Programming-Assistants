class Solution:
    def maxFreeTime(self, events: List[List[int]]) -> int:
        events.sort()
        max_free = 0
        prev_end = events[0][1]
        for start, end in events[1:]:
            if start > prev_end:
                max_free = max(max_free, start - prev_end)
            prev_end = max(prev_end, end)
        return max_free