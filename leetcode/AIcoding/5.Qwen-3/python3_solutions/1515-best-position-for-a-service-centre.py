class Solution:
    def bestPosition(self, points: List[List[int]]) -> List[int]:
        from math import sqrt

        def distance(p1, p2):
            return sqrt((p1[0] - p2[0])**2 + (p1[1] - p2[1])**2)

        def getMedian(arr):
            arr.sort()
            n = len(arr)
            if n % 2 == 1:
                return arr[n // 2]
            else:
                return (arr[n // 2 - 1] + arr[n // 2]) // 2

        x_coords = [x for x, y in points]
        y_coords = [y for x, y in points]

        x_median = getMedian(x_coords)
        y_median = getMedian(y_coords)

        return [x_median, y_median]