class Solution:
    def numberOfArithmeticSlices(self, nums: list[int]) -> int:
        n = len(nums)
        if n < 3:
            return 0
        count = 0
        diff = nums[1] - nums[0]
        length = 2
        for i in range(2, n):
            if nums[i] - nums[i-1] == diff:
                length += 1
            else:
                diff = nums[i] - nums[i-1]
                length = 2
            if length >= 2:
                count += length - 1
        return count