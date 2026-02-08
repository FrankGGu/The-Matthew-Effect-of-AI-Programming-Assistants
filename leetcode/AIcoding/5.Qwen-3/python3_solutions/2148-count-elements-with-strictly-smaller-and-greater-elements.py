class Solution:
    def countElements(self, nums: List[int]) -> int:
        min_val = min(nums)
        max_val = max(nums)
        count = 0
        for num in nums:
            if num > min_val and num < max_val:
                count += 1
        return count