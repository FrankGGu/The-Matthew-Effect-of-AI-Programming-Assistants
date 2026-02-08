class Interval:
    def __init__(self, s=0, e=0):
        self.start = s
        self.end = e

class Solution:
    def merge(self, intervals: List[Interval]) -> List[Interval]:
        if not intervals:
            return []
        intervals.sort(key=lambda x: x.start)
        merged = [intervals[0]]
        for current in intervals[1:]:
            last = merged[-1]
            if current.start <= last.end:
                last.end = max(last.end, current.end)
            else:
                merged.append(current)
        return merged