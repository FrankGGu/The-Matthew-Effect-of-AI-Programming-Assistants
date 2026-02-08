class Solution:
    def checkOverlap(self, radius: int, xCenter1: int, yCenter1: int, xCenter2: int, yCenter2: int, xCorner2: int, yCorner2: int) -> bool:
        x = max(xCenter2, min(xCenter1, xCorner2))
        y = max(yCenter2, min(yCenter1, yCorner2))
        dx = xCenter1 - x
        dy = yCenter1 - y
        return dx * dx + dy * dy <= radius * radius