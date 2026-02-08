class Solution:
    def sumOfSubarrays(self, nums: List[int]) -> int:
        n = len(nums)
        total = 0
        for i in range(n):
            for j in range(i, n):
                total += sum(nums[i:j+1])
        return total