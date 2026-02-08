import math

class Solution:
    def visiblePoints(self, points: List[List[int]], angle: int, x: int, y: int) -> int:
        angles = []
        for px, py in points:
            dx = px - x
            dy = py - y
            if dx == 0 and dy == 0:
                continue
            rad = math.atan2(dy, dx)
            deg = math.degrees(rad)
            angles.append(deg)

        angles.sort()
        n = len(angles)
        for i in range(n):
            angles.append(angles[i] + 360)

        max_count = 0
        left = 0
        for right in range(n * 2):
            while angles[right] - angles[left] > angle:
                left += 1
            max_count = max(max_count, right - left + 1)

        return max_count