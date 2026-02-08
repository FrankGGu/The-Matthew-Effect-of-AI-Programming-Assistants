class RangeFrequencyQueries:
    def __init__(self, arr: List[int]):
        from collections import defaultdict
        self.freq = defaultdict(lambda: defaultdict(int))
        for i, num in enumerate(arr):
            self.freq[num][i] += 1

    def query(self, left: int, right: int, value: int) -> int:
        from bisect import bisect_left, bisect_right
        positions = self.freq[value]
        l = bisect_left(positions, left)
        r = bisect_right(positions, right)
        return r - l