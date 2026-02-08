class Solution:
    def area(self, rectangles):
        max_area = 0
        for x1, y1, x2, y2 in rectangles:
            width = abs(x2 - x1)
            height = abs(y2 - y1)
            area = width * height
            if area > max_area:
                max_area = area
        return max_area