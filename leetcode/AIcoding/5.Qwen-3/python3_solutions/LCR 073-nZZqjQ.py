class Solution:
    def minEatingSpeed(self, piles: List[int], h: int) -> int:
        def canEat(speed):
            hours = 0
            for pile in piles:
                hours += (pile + speed - 1) // speed
                if hours > h:
                    return False
            return True

        left, right = 1, max(piles)
        while left < right:
            mid = (left + right) // 2
            if canEat(mid):
                right = mid
            else:
                left = mid + 1
        return left