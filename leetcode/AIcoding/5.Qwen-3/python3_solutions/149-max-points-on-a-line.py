from collections import defaultdict
from math import gcd

class Solution:
    def maxPoints(self, points: List[List[int]]) -> int:
        if len(points) <= 2:
            return len(points)

        max_points = 0

        for i in range(len(points)):
            x1, y1 = points[i]
            slope_count = defaultdict(int)
            same_point = 0
            current_max = 0

            for j in range(len(points)):
                if i == j:
                    continue
                x2, y2 = points[j]

                dx = x2 - x1
                dy = y2 - y1

                if dx == 0 and dy == 0:
                    same_point += 1
                    continue

                gcd_val = gcd(dx, dy)
                if gcd_val != 0:
                    dx //= gcd_val
                    dy //= gcd_val

                slope = (dx, dy)
                slope_count[slope] += 1
                current_max = max(current_max, slope_count[slope])

            max_points = max(max_points, current_max + same_point + 1)

        return max_points