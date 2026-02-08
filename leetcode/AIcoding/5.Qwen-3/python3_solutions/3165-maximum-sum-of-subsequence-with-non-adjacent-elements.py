class Solution:
    def maxSum(self, nums: List[int]) -> int:
        if not nums:
            return 0
        if len(nums) == 1:
            return nums[0]
        prev = nums[0]
        curr = max(nums[0], nums[1])
        for i in range(2, len(nums)):
            temp = curr
            curr = max(curr, prev + nums[i])
            prev = temp
        return curr