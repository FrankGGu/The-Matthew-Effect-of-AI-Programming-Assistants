class Solution:
    def countGoodRectangles(self, rectangles: List[List[int]]) -> int:
        max_side = 0
        count = 0
        for l, w in rectangles:
            side = min(l, w)
            if side > max_side:
                max_side = side
                count = 1
            elif side == max_side:
                count += 1
        return count