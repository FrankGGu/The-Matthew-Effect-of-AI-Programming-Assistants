class Solution:
    def numberOfSubarrays(self, nums: List[int], k: int) -> int:
        from collections import defaultdict

        count = defaultdict(int)
        count[0] = 1
        res = 0
        prefix = 0

        for num in nums:
            prefix += num % 2
            res += count[prefix - k]
            count[prefix] += 1

        return res