class Solution:
    def minMoves(self, target: int, a: int, b: int, lang: int) -> int:
        import math
        total = a + b
        return (target + lang - 1) // lang