class Solution:
    def maxFrequencyElements(self, nums: List[int]) -> int
        from collections import Counter

        freq = Counter(nums)
        max_freq = max(freq.values())
        count = 0
        for v in freq.values():
            if v == max_freq:
                count += v
        return count