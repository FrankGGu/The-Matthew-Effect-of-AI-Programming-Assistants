class Solution:
    def countSubarrays(self, nums: List[int]) -> int:
        n = len(nums)
        res = 0
        for i in range(n):
            j = i
            while j + 1 < n and nums[j + 1] == nums[j] + 1:
                j += 1
            length = j - i + 1
            res += (length * (length - 1)) // 2
            i = j
        return res