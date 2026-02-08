class Solution:
    def semiOrderedPermutation(self, nums: List[int]) -> int:
        n = len(nums)
        swaps = 0
        for i in range(n):
            if nums[i] == i + 1:
                continue
            if nums[i] == i + 2 and nums[i + 1] == i + 1:
                nums[i], nums[i + 1] = nums[i + 1], nums[i]
                swaps += 1
            else:
                j = nums.index(i + 1)
                nums[i], nums[j] = nums[j], nums[i]
                swaps += 1
        return swaps