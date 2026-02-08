class Solution:
    def maxNumberOfNonOverlappingSubstrings(self, s: str) -> int:
        from collections import defaultdict

        def get_ranges(s):
            first = {}
            last = {}
            for i, c in enumerate(s):
                if c not in first:
                    first[c] = i
                last[c] = i
            return first, last

        first, last = get_ranges(s)
        intervals = []
        for c in first:
            intervals.append((first[c], last[c], c))
        intervals.sort()
        res = 0
        end = -1
        for start, end_, _ in intervals:
            if start > end:
                res += 1
                end = end_
        return res