class Solution:
    def zeroFilledSubarrays(self, nums: List[int]) -> int:
        count = 0
        i = 0
        while i < len(nums):
            if nums[i] == 0:
                j = i
                while j < len(nums) and nums[j] == 0:
                    j += 1
                n = j - i
                count += n * (n + 1) // 2
                i = j
            else:
                i += 1
        return count