class Solution:
    def minOperations(self, target: List[int], arr: List[int]) -> int:
        from collections import defaultdict

        count = defaultdict(int)
        for num in target:
            count[num] += 1

        for num in arr:
            if count[num] > 0:
                count[num] -= 1

        operations = 0
        for v in count.values():
            operations += v

        return operations