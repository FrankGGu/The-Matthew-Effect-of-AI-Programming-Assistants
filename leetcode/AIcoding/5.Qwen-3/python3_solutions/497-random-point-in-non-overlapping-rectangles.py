import random
from bisect import bisect_right

class Solution:

    def __init__(self, rects: List[List[int]]):
        self.rects = rects
        self.prefix = []
        for x1, y1, x2, y2 in rects:
            area = (x2 - x1 + 1) * (y2 - y1 + 1)
            self.prefix.append(area + (self.prefix[-1] if self.prefix else 0))

    def pick(self) -> List[int]:
        total = self.prefix[-1]
        rand = random.randint(1, total)
        idx = bisect_right(self.prefix, rand) - 1
        x1, y1, x2, y2 = self.rects[idx]
        return [random.randint(x1, x2), random.randint(y1, y2)]