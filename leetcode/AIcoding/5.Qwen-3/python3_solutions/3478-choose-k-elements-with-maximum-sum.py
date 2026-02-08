class Solution:
    def maximumSum(self, nums, k):
        nums.sort(reverse=True)
        return sum(nums[:k])