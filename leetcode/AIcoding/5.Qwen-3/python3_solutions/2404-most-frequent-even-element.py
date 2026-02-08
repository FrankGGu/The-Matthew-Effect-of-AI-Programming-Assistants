from typing import List

class Solution:
    def mostFrequentEven(self, nums: List[int]) -> int:
        from collections import defaultdict

        count = defaultdict(int)
        max_freq = 0
        result = -1

        for num in nums:
            if num % 2 == 0:
                count[num] += 1
                if count[num] > max_freq or (count[num] == max_freq and num < result):
                    max_freq = count[num]
                    result = num

        return result