class Solution:
    def minCost(self, n: int, horizontalCuts: List[int], verticalCuts: List[int]) -> int:
        horizontalCuts.sort()
        verticalCuts.sort()
        maxH = 0
        prev = 0
        for h in horizontalCuts:
            maxH = max(maxH, h - prev)
            prev = h
        maxH = max(maxH, n - prev)

        maxV = 0
        prev = 0
        for v in verticalCuts:
            maxV = max(maxV, v - prev)
            prev = v
        maxV = max(maxV, n - prev)

        return (maxH * maxV) % (10**9 + 7)