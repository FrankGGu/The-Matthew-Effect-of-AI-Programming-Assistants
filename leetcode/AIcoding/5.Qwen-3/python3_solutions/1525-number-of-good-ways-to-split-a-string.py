class Solution:
    def numGoodPairs(self, nums: List[int]) -> int:
        from collections import defaultdict
        count = defaultdict(int)
        result = 0
        for num in nums:
            result += count[num]
            count[num] += 1
        return result