class Solution:
    def maxArea(self, h: int, w: int, horizontalCuts: List[int], verticalCuts: List[int]) -> int:
        horizontalCuts.sort()
        verticalCuts.sort()
        maxH = 0
        for i in range(1, len(horizontalCuts)):
            maxH = max(maxH, horizontalCuts[i] - horizontalCuts[i-1])
        maxH = max(maxH, horizontalCuts[0])
        maxH = max(maxH, h - horizontalCuts[-1])

        maxV = 0
        for i in range(1, len(verticalCuts)):
            maxV = max(maxV, verticalCuts[i] - verticalCuts[i-1])
        maxV = max(maxV, verticalCuts[0])
        maxV = max(maxV, w - verticalCuts[-1])

        return (maxH * maxV) % (10**9 + 7)