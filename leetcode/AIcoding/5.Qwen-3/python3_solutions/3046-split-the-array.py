class Solution:
    def splitArray(self, nums: List[int], m: int) -> int:
        def canSplit(max_sum):
            count = 1
            current_sum = 0
            for num in nums:
                current_sum += num
                if current_sum > max_sum:
                    count += 1
                    current_sum = num
                    if count > m:
                        return False
            return True

        left = max(nums)
        right = sum(nums)
        while left < right:
            mid = (left + right) // 2
            if canSplit(mid):
                right = mid
            else:
                left = mid + 1
        return left