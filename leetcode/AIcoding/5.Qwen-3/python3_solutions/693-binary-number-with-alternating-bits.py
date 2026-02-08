class Solution:
    def hasAlternatingBits(self, n: int) -> bool:
        prev = n & 1
        n >>= 1
        while n:
            current = n & 1
            if current == prev:
                return False
            prev = current
            n >>= 1
        return True