class Solution:
    def numSpecialOdds(self, nums: List[int]) -> int:
        count = 0
        for num in nums:
            if num % 2 == 1:
                count += 1
        return count