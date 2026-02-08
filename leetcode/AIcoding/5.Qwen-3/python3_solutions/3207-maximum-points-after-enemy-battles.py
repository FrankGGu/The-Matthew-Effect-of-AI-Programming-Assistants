class Solution:
    def maxPoints(self, points: List[List[int]]) -> int:
        from collections import defaultdict

        def get_key(x, y):
            return (x, y)

        def get_slope(p1, p2):
            x1, y1 = p1
            x2, y2 = p2
            dx = x2 - x1
            dy = y2 - y1
            if dx == 0:
                return (float('inf'), 1)
            if dy == 0:
                return (0, 1)
            gcd_val = math.gcd(dx, dy)
            dx //= gcd_val
            dy //= gcd_val
            if dx < 0:
                dx *= -1
                dy *= -1
            return (dy, dx)

        n = len(points)
        if n == 1:
            return 0
        max_points = 0
        for i in range(n):
            slope_count = defaultdict(int)
            same_point = 0
            current_max = 0
            for j in range(n):
                if i == j:
                    continue
                if points[i] == points[j]:
                    same_point += 1
                else:
                    slope = get_slope(points[i], points[j])
                    slope_count[slope] += 1
                    current_max = max(current_max, slope_count[slope])
            max_points = max(max_points, current_max + same_point + 1)
        return max_points