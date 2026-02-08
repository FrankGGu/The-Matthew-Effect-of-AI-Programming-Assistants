class Solution:
    def numberOfPoints(self, times: List[List[int]]) -> int:
        points = set()
        for start, end in times:
            for i in range(start, end + 1):
                points.add(i)
        return len(points)