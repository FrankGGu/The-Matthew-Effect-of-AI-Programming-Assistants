from collections import defaultdict

class Solution:
    def maxEqualFreq(self, nums: List[int]) -> int:
        freq = defaultdict(int)
        count = defaultdict(int)
        max_freq = 0
        result = 0
        for i, num in enumerate(nums):
            freq[num] += 1
            count[freq[num]] += 1
            if freq[num] > max_freq:
                max_freq = freq[num]
            if (max_freq == 1) or (count[max_freq] == 1 and max_freq * count[max_freq] == i + 1) or (count[max_freq - 1] == 1 and (max_freq - 1) * count[max_freq - 1] + 1 == i + 1):
                result = i + 1
        return result