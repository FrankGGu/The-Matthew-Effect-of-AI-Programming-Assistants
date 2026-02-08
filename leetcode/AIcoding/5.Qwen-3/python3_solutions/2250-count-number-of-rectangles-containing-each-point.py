class Solution:
    def countRectangles(self, rectangles: List[List[int]], points: List[List[int]]) -> List[int]:
        from collections import defaultdict

        x_to_y = defaultdict(list)
        for x, y in rectangles:
            x_to_y[x].append(y)

        for x in x_to_y:
            x_to_y[x].sort()

        res = []
        for x, y in points:
            cnt = 0
            for x_rect in x_to_y:
                if x_rect >= x:
                    ys = x_to_y[x_rect]
                    idx = bisect.bisect_left(ys, y)
                    cnt += len(ys) - idx
            res.append(cnt)
        return res