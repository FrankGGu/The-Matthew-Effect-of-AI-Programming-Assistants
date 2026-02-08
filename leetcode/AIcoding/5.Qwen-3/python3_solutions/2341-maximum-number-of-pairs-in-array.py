class Solution:
    def maximumNumberOfPairs(self, nums: List[int]) -> int:
        from collections import Counter

        count = Counter(nums)
        pairs = 0

        for num in count:
            pairs += count[num] // 2

        return pairs