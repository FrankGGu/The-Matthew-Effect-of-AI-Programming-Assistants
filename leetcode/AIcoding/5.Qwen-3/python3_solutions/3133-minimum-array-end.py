class Solution:
    def minArrayEnd(self, nums: List[int], target: int) -> int:
        n = len(nums)
        res = 0
        for i in range(n):
            res |= nums[i]
            if res == target:
                return res
        return target