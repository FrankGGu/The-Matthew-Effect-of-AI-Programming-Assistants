class Solution:
    def minMovesToMakeArrayZigzag(self, nums: List[int]) -> int:
        n = len(nums)
        if n <= 2:
            return 0
        res = 0
        for i in range(1, n - 1, 2):
            if nums[i] >= nums[i - 1]:
                res += nums[i] - nums[i - 1] + 1
                nums[i] = nums[i - 1] - 1
            if nums[i] >= nums[i + 1]:
                res += nums[i] - nums[i + 1] + 1
                nums[i] = nums[i + 1] - 1
        for i in range(2, n - 1, 2):
            if nums[i] >= nums[i - 1]:
                res += nums[i] - nums[i - 1] + 1
                nums[i] = nums[i - 1] - 1
            if nums[i] >= nums[i + 1]:
                res += nums[i] - nums[i + 1] + 1
                nums[i] = nums[i + 1] - 1
        return res