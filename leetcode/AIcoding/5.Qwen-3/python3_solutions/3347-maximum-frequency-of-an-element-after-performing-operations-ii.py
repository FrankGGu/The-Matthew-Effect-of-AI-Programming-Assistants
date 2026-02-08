from collections import defaultdict
from typing import List

class Solution:
    def maxFrequency(self, nums: List[int], k: int) -> int:
        nums.sort()
        left = 0
        max_freq = 0
        freq = defaultdict(int)
        for right in range(len(nums)):
            freq[nums[right]] += 1
            while (nums[right] * (right - left + 1)) - sum(freq) > k:
                freq[nums[left]] -= 1
                if freq[nums[left]] == 0:
                    del freq[nums[left]]
                left += 1
            max_freq = max(max_freq, sum(freq.values()))
        return max_freq