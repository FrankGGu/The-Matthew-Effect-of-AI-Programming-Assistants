class Solution:
    def minimumAverageDifference(self, nums: List[int]) -> int:
        n = len(nums)
        total = sum(nums)
        left_sum = 0
        min_diff = float('inf')
        result = 0
        for i in range(n):
            left_sum += nums[i]
            right_sum = total - left_sum
            left_avg = left_sum // (i + 1)
            if i == n - 1:
                right_avg = 0
            else:
                right_avg = right_sum // (n - i - 1)
            diff = abs(left_avg - right_avg)
            if diff < min_diff:
                min_diff = diff
                result = i
        return result