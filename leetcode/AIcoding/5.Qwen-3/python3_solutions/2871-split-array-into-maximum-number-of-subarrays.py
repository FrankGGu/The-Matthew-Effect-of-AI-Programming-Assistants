class Solution:
    def maxSubarrays(self, nums: List[int]) -> int:
        result = 0
        current = float('inf')
        for num in nums:
            current &= num
            if current == 0:
                result += 1
                current = float('inf')
        return result if result > 0 else 0