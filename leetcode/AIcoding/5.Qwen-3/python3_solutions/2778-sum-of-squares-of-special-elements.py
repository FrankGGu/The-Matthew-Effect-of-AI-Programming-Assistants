class Solution:
    def sumOfSquares(self, nums: List[int]) -> int:
        n = len(nums)
        total = 0
        for i in range(n):
            if i % 2 == 0:
                total += nums[i] ** 2
        return total