class Solution:
    def isReachable(self, target: int) -> bool:
        while target % 2 == 0:
            target //= 2
        return target == 1