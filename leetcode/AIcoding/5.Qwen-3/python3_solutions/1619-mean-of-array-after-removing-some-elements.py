class Solution:
    def ofMean(self, nums: List[int]) -> float:
        nums.sort()
        n = len(nums)
        if n <= 2:
            return 0.0
        total = sum(nums[1:-1])
        return total / (n - 2)