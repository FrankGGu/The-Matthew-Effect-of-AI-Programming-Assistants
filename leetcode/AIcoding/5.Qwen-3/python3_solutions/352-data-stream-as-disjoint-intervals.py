class SummaryRanges:
    def __init__(self):
        self.intervals = []

    def addNum(self, val: int) -> None:
        new_intervals = []
        added = False
        for interval in self.intervals:
            if interval[1] + 1 < val:
                new_intervals.append(interval)
            elif interval[0] > val + 1:
                if not added:
                    new_intervals.append([val, val])
                    added = True
                new_intervals.append(interval)
            else:
                val = min(val, interval[0])
                val = max(val, interval[1])
        if not added:
            new_intervals.append([val, val])
        self.intervals = new_intervals

    def getIntervals(self) -> List[List[int]]:
        return self.intervals