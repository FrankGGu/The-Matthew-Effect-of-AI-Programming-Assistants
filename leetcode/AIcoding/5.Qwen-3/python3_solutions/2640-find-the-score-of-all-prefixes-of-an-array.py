class Solution:
    def findPrefixScores(self, nums: List[int]) -> List[int]:
        n = len(nums)
        res = [0] * n
        current_sum = 0
        for i in range(n):
            current_sum += nums[i]
            res[i] = current_sum
        return res