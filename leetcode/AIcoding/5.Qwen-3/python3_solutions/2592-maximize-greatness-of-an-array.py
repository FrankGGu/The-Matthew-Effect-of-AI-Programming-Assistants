class Solution:
    def maxGreatness(self, nums: List[int]) -> int:
        from collections import Counter

        count = Counter(nums)
        res = 0
        for num in nums:
            if count[num] > 0:
                res += 1
                count[num] -= 1
        return res