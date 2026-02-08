class Solution:
    def findBestTarget(self, nums: List[int], target: int) -> int:
        def get_sum(m):
            return sum(min(num, m) for num in nums)

        left, right = 0, target
        best = 0
        while left <= right:
            mid = (left + right) // 2
            s = get_sum(mid)
            if s == target:
                return mid
            elif s < target:
                best = mid
                left = mid + 1
            else:
                right = mid - 1
        return best