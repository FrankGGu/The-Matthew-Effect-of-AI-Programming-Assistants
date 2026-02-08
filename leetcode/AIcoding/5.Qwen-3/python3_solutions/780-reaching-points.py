class Solution:
    def reachNumber(self, target: int) -> int:
        target = abs(target)
        k = 0
        while target > 0:
            target -= k
            k += 1
        while target % 2 != 0:
            target += k
            k += 1
        return k - 1