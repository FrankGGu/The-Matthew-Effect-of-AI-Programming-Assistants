class Interval:
    def __init__(self, start: int = 0, end: int = 0):
        self.start = start
        self.end = end

class Solution:
    def findRightInterval(self, intervals: List[Interval]) -> List[int]:
        import bisect

        sorted_intervals = sorted((interval.start, i) for i, interval in enumerate(intervals))
        result = [-1] * len(intervals)

        for i, interval in enumerate(intervals):
            index = bisect.bisect_left(sorted_intervals, (interval.end,))
            if index < len(sorted_intervals):
                result[i] = sorted_intervals[index][1]

        return result