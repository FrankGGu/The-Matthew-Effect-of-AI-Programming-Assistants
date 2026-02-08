class Solution:
    def numMoves(self, a: int, b: int, c: int) -> int:
        x, y, z = sorted([a, b, c])
        if z - y == 1 and y - x == 1:
            return 0
        if z - y == 1 or y - x == 1:
            return 1
        return (z - y - 1) + (y - x - 1)