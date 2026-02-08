class Solution:
    def maxNumber of DartsInside(self, darts: List[List[int]], r: int) -> int:
        from itertools import combinations
        import math

        def dist(p1, p2):
            return math.hypot(p1[0] - p2[0], p1[1] - p2[1])

        def circle_from_two_points(p1, p2, r):
            if dist(p1, p2) > 2 * r:
                return None
            dx = p2[0] - p1[0]
            dy = p2[1] - p1[1]
            d = math.hypot(dx, dy)
            if d == 0:
                return None
            mid_x = (p1[0] + p2[0]) / 2
            mid_y = (p1[1] + p2[1]) / 2
            h = math.sqrt(r * r - (d / 2) ** 2)
            cx = mid_x - (dy * h) / d
            cy = mid_y + (dx * h) / d
            return (cx, cy)

        def is_point_in_circle(point, center, r):
            return dist(point, center) <= r + 1e-8

        max_count = 0
        n = len(darts)
        for i in range(n):
            for j in range(i + 1, n):
                p1 = darts[i]
                p2 = darts[j]
                if dist(p1, p2) > 2 * r:
                    continue
                center = circle_from_two_points(p1, p2, r)
                if center is not None:
                    count = 0
                    for k in range(n):
                        if is_point_in_circle(darts[k], center, r):
                            count += 1
                    max_count = max(max_count, count)
        for i in range(n):
            count = 0
            for j in range(n):
                if dist(darts[i], darts[j]) <= r + 1e-8:
                    count += 1
            max_count = max(max_count, count)
        return max_count