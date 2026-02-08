class Solution:
    def minimumOperations(self, nums: List[int]) -> int:
        from collections import defaultdict

        count = defaultdict(int)
        for num in nums:
            if num != 0:
                count[num] += 1

        operations = 0
        for key in count:
            operations += count[key]

        return operations