class Solution:
    def maxRotateFunction(self, nums) -> int:
        n = len(nums)
        total = sum(nums)
        current = 0
        for i in range(n):
            current += i * nums[i]
        max_score = current
        for i in range(1, n):
            current = current + total - n * nums[n - i]
            if current > max_score:
                max_score = current
        return max_score