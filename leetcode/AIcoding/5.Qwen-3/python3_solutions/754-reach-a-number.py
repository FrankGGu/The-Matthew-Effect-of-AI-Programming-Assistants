class Solution:
    def reachNumber(self, target: int) -> int:
        target = abs(target)
        k = 0
        while True:
            if (k * (k + 1)) // 2 >= target and (k * (k + 1)) // 2 - target % 2 == 0:
                return k
            k += 1