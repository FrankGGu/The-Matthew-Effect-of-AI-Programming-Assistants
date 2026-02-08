class Solution:
    def minLengthAfterRemovals(self, nums: List[int]) -> int:
        from collections import Counter

        count = Counter(nums)
        max_freq = max(count.values())
        n = len(nums)

        if max_freq > n // 2:
            return 2 * max_freq - n
        else:
            return n % 2