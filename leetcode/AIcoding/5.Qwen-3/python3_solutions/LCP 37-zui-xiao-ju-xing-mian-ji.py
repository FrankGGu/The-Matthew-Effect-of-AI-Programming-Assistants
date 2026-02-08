class Solution:
    def minAreaRect(self, image: List[List[int]]) -> int:
        rows = len(image)
        cols = len(image[0]) if rows > 0 else 0
        points = []
        for i in range(rows):
            for j in range(cols):
                if image[i][j] == 1:
                    points.append((i, j))
        if len(points) < 4:
            return 0
        points.sort()
        min_area = float('inf')
        for i in range(len(points)):
            for j in range(i + 1, len(points)):
                x1, y1 = points[i]
                x2, y2 = points[j]
                if x1 != x2 and y1 != y2:
                    if (x1, y2) in points and (x2, y1) in points:
                        area = abs(x1 - x2) * abs(y1 - y2)
                        min_area = min(min_area, area)
        return min_area if min_area != float('inf') else 0