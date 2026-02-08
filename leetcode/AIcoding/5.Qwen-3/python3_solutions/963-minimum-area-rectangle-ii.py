class Solution:
    def minAreaFreeRect(self, points: List[List[int]]) -> float:
        from collections import defaultdict
        import math

        points = [tuple(p) for p in points]
        point_set = set(points)
        result = float('inf')

        for i in range(len(points)):
            for j in range(i + 1, len(points)):
                p1 = points[i]
                p2 = points[j]
                mid = ((p1[0] + p2[0]) / 2, (p1[1] + p2[1]) / 2)
                dx = p1[0] - p2[0]
                dy = p1[1] - p2[1]
                key = (mid, dx * dx + dy * dy)
                for k in range(i + 1, len(points)):
                    p3 = points[k]
                    if p3 == p1 or p3 == p2:
                        continue
                    if (p1[0] + p3[0]) / 2 == mid[0] and (p1[1] + p3[1]) / 2 == mid[1]:
                        p4 = (p2[0] + p3[0] - p1[0], p2[1] + p3[1] - p1[1])
                        if p4 in point_set:
                            area = (math.hypot(p1[0] - p3[0], p1[1] - p3[1])) * (math.hypot(p2[0] - p3[0], p2[1] - p3[1]))
                            result = min(result, area)
                if (p1[0] + p2[0]) / 2 == mid[0] and (p1[1] + p2[1]) / 2 == mid[1]:
                    for k in range(j + 1, len(points)):
                        p3 = points[k]
                        if p3 == p1 or p3 == p2:
                            continue
                        if (p1[0] + p3[0]) / 2 == mid[0] and (p1[1] + p3[1]) / 2 == mid[1]:
                            p4 = (p2[0] + p3[0] - p1[0], p2[1] + p3[1] - p1[1])
                            if p4 in point_set:
                                area = (math.hypot(p1[0] - p3[0], p1[1] - p3[1])) * (math.hypot(p2[0] - p3[0], p2[1] - p3[1]))
                                result = min(result, area)

        return result if result != float('inf') else 0.0