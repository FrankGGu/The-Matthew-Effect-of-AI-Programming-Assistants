class Solution:
    def findMinDifference(self, timePoints: List[str]) -> int:
        timePoints.sort()
        min_diff = float('inf')
        for i in range(len(timePoints)):
            h1, m1 = map(int, timePoints[i].split(':'))
            h2, m2 = map(int, timePoints[(i + 1) % len(timePoints)].split(':'))
            diff = (h2 - h1) * 60 + (m2 - m1)
            if diff > 720:
                diff -= 1440
            min_diff = min(min_diff, diff)
        return min_diff