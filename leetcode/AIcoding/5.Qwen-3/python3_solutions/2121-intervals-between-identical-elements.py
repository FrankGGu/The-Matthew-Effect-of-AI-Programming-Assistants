from typing import List

class Solution:
    def findOptimalIndices(self, nums: List[int]) -> List[int]:
        from collections import defaultdict

        pos = defaultdict(list)
        for i, num in enumerate(nums):
            pos[num].append(i)

        res = [0] * len(nums)
        for key in pos:
            indices = pos[key]
            n = len(indices)
            for i in range(n):
                left = 0
                right = 0
                for j in range(i):
                    left += indices[i] - indices[j]
                for j in range(i + 1, n):
                    right += indices[j] - indices[i]
                res[indices[i]] = left + right
        return res