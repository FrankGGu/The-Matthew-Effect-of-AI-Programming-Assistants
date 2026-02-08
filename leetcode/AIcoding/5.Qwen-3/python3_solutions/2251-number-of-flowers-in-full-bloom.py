from bisect import bisect_right, bisect_left
from collections import defaultdict

class Solution:
    def fullBloomFlowers(self, flowers: List[List[int]], people: List[int]) -> List[int]:
        start = []
        end = []
        for s, e in flowers:
            start.append(s)
            end.append(e)
        start.sort()
        end.sort()
        res = []
        for t in people:
            cnt = bisect_right(start, t) - bisect_left(end, t)
            res.append(cnt)
        return res