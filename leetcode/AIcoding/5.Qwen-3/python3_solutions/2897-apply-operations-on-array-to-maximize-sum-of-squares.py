class Solution:
    def maximizeSum(self, nums: List[int], k: int) -> int:
        nums.sort(reverse=True)
        res = 0
        for i in range(k):
            res += nums[0] ** 2
            nums[0] += 1
        return res