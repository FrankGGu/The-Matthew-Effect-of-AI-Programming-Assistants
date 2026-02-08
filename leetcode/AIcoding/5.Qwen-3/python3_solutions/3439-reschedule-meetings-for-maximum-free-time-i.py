class Solution:
    def maxFreeTime(self, intervals: List[List[int]]) -> int:
        intervals.sort()
        max_free = 0
        prev_end = intervals[0][1]
        for start, end in intervals[1:]:
            if start > prev_end:
                max_free = max(max_free, start - prev_end)
            prev_end = max(prev_end, end)
        return max_free