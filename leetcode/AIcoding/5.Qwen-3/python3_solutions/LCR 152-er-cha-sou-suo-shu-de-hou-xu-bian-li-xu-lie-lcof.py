class Solution:
    def verifyPostorder(self, nums: list[int]) -> bool:
        def helper(nums, low, high):
            if low >= high:
                return True
            root = nums[high]
            i = low
            while i < high and nums[i] < root:
                i += 1
            j = i
            while j < high:
                if nums[j] < root:
                    return False
                j += 1
            return helper(nums, low, i - 1) and helper(nums, i, high - 1)

        return helper(nums, 0, len(nums) - 1)