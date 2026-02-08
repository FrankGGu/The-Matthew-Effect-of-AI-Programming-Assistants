from typing import List

class Solution:
    def findLongestEqualSubarray(self, nums: List[int], k: int) -> int:
        from collections import defaultdict

        index_map = defaultdict(list)
        for i, num in enumerate(nums):
            index_map[num].append(i)

        max_length = 0
        for indices in index_map.values():
            left = 0
            for right in range(len(indices)):
                while indices[right] - indices[left] > k:
                    left += 1
                max_length = max(max_length, right - left + 1)

        return max_length