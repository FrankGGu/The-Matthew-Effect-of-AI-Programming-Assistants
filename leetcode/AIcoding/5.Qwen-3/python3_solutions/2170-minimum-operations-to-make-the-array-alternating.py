from collections import Counter
from typing import List

class Solution:
    def numberOfAlternatingOccurrences(self, nums: List[int]) -> int:
        if len(nums) == 1:
            return 0

        count = Counter()
        for i in range(0, len(nums), 2):
            count[nums[i]] += 1

        max_freq = 0
        second_max_freq = 0
        for freq in count.values():
            if freq > max_freq:
                second_max_freq = max_freq
                max_freq = freq
            elif freq > second_max_freq:
                second_max_freq = freq

        total = 0
        for i in range(1, len(nums), 2):
            total += 1

        if max_freq + second_max_freq < total:
            return total - max_freq
        else:
            return total - max_freq - 1

    def minimumOperations(self, nums: List[int]) -> int:
        if len(nums) == 1:
            return 1

        even_count = Counter()
        odd_count = Counter()

        for i in range(len(nums)):
            if i % 2 == 0:
                even_count[nums[i]] += 1
            else:
                odd_count[nums[i]] += 1

        even_max = 0
        even_second = 0
        for freq in even_count.values():
            if freq > even_max:
                even_second = even_max
                even_max = freq
            elif freq > even_second:
                even_second = freq

        odd_max = 0
        odd_second = 0
        for freq in odd_count.values():
            if freq > odd_max:
                odd_second = odd_max
                odd_max = freq
            elif freq > odd_second:
                odd_second = freq

        if even_max != odd_max:
            return len(nums) - even_max - odd_max
        else:
            return len(nums) - max(even_max + odd_second, even_second + odd_max)