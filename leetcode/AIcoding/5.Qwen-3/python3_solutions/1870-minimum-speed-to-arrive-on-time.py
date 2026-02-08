class Solution:
    def minSpeedOnTime(self, dist: List[int], hour: float) -> int:
        if len(dist) == 0:
            return 0
        def canReach(speed):
            time = 0.0
            for d in dist:
                time += d / speed
                if time > hour:
                    return False
            return time <= hour
        left, right = 1, 10**6
        result = -1
        while left <= right:
            mid = (left + right) // 2
            if canReach(mid):
                result = mid
                right = mid - 1
            else:
                left = mid + 1
        return result