class Solution:
    def maxArea(self, points: List[List[int]], queries: List[List[int]]) -> List[int]:
        def area(x1, y1, x2, y2):
            return abs((x2 - x1) * (y2 - y1))

        res = []
        for q in queries:
            x, y, w, h = q
            max_area = 0
            for p in points:
                px, py = p
                if x <= px <= x + w and y <= py <= y + h:
                    max_area = max(max_area, area(x, y, px, py))
            res.append(max_area)
        return res