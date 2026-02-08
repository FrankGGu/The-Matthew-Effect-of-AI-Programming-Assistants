class Solution:
    def maximumLength(self, nums: List[int]) -> int:
        from collections import defaultdict

        count = defaultdict(int)
        for num in nums:
            count[num] += 1

        max_len = 0
        for num in count:
            current = num
            length = 0
            while current in count:
                length += count[current]
                current *= 2
            max_len = max(max_len, length)

        return max_len