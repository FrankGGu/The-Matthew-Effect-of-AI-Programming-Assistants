class Solution:
    def applyOperations(self, nums: List[int]) -> List[int]:
        n = len(nums)
        for i in range(n):
            if nums[i] != 0:
                j = i
                while j + 1 < n and nums[j + 1] == 0:
                    nums[j], nums[j + 1] = nums[j + 1], nums[j]
                    j += 1
        return nums