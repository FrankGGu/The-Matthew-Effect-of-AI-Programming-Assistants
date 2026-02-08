class Solution:
    def maxArea(self, points: List[List[int]], queries: List[List[int]]) -> List[int]:
        def area(rect):
            x1, y1, x2, y2 = rect
            return (x2 - x1) * (y2 - y1)

        def contains(point, rect):
            x, y = point
            x1, y1, x2, y2 = rect
            return x1 <= x <= x2 and y1 <= y <= y2

        result = []
        for q in queries:
            x1, y1, x2, y2 = q
            max_area = 0
            for p in points:
                if contains(p, (x1, y1, x2, y2)):
                    for p2 in points:
                        if contains(p2, (x1, y1, x2, y2)):
                            for p3 in points:
                                if contains(p3, (x1, y1, x2, y2)):
                                    for p4 in points:
                                        if contains(p4, (x1, y1, x2, y2)):
                                            if len(set((p, p2, p3, p4))) == 4:
                                                rect = (min(p[0], p2[0], p3[0], p4[0]), min(p[1], p2[1], p3[1], p4[1]), max(p[0], p2[0], p3[0], p4[0]), max(p[1], p2[1], p3[1], p4[1]))
                                                if area(rect) > max_area:
                                                    max_area = area(rect)
            result.append(max_area)
        return result