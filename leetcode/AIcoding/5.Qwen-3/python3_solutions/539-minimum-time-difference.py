class Solution:
    def findMinDifference(self, timePoints: List[str]) -> int:
        def toMinutes(time):
            h, m = map(int, time.split(':'))
            return h * 60 + m

        timePoints.sort(key=toMinutes)
        minDiff = float('inf')
        n = len(timePoints)
        for i in range(n):
            diff = abs(toMinutes(timePoints[i]) - toMinutes(timePoints[(i + 1) % n]))
            minDiff = min(minDiff, diff, 1440 - diff)
        return minDiff