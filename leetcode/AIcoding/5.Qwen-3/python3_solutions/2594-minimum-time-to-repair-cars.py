class Solution:
    def minRepairTime(self, cars: List[int], repairTime: List[int]) -> int:
        def can_repair(time):
            total = 0
            for t in repairTime:
                total += time // t
                if total >= len(cars):
                    return True
            return total >= len(cars)

        left, right = 0, max(repairTime) * len(cars)
        while left < right:
            mid = (left + right) // 2
            if can_repair(mid):
                right = mid
            else:
                left = mid + 1
        return left