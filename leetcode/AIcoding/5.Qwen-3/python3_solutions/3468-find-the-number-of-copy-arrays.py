class Solution:
    def numberOfCopyArrays(self, nums: List[int]) -> int:
        from collections import defaultdict

        count = defaultdict(int)
        for num in nums:
            count[num] += 1

        result = 1
        for v in count.values():
            result *= v

        return result