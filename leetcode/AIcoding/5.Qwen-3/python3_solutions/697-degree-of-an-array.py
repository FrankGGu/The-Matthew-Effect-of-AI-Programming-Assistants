class Solution:
    def findShortestSubArray(self, nums: List[int]) -> int:
        from collections import defaultdict

        count = defaultdict(int)
        first_occurrence = {}
        last_occurrence = {}

        for i, num in enumerate(nums):
            count[num] += 1
            if num not in first_occurrence:
                first_occurrence[num] = i
            last_occurrence[num] = i

        max_count = max(count.values())
        min_length = float('inf')

        for num in count:
            if count[num] == max_count:
                length = last_occurrence[num] - first_occurrence[num] + 1
                min_length = min(min_length, length)

        return min_length