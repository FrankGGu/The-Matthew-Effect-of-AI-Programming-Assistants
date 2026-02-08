class Solution:
    def maxValue(self, nums: List[int], k: int) -> int:
        nums.sort()
        max_val = 0
        for i in range(len(nums) - k + 1):
            current = nums[i + k - 1] - nums[i]
            if current > max_val:
                max_val = current
        return max_val