class Solution:
    def numBadPairs(self, nums: List[int]) -> int:
        from collections import defaultdict
        count = defaultdict(int)
        res = 0
        for i, num in enumerate(nums):
            res += count[num]
            count[num] += 1
        return len(nums) * (len(nums) - 1) // 2 - res