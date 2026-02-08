class Solution:
    def numberOfSubarrays(self, nums: List[int], k: int) -> int:
        from collections import defaultdict

        count = defaultdict(int)
        count[0] = 1
        res = 0
        curr = 0

        for num in nums:
            curr += num % 2
            res += count[curr - k]
            count[curr] += 1

        return res