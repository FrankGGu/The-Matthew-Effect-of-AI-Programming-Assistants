class Solution:
    def isGood(self, nums: List[int]) -> bool:
        from collections import Counter
        count = Counter(nums)
        for num in count:
            if num == 1 and count[num] != 1:
                return False
            elif num > 1 and count[num] != 2:
                return False
        return True