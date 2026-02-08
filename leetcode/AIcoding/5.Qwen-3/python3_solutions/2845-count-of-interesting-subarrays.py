class Solution:
    def countInterestingSubarrays(self, nums: List[int], k: int) -> int
        from collections import defaultdict

        count = defaultdict(int)
        count[0] = 1
        result = 0
        mod = 0

        for num in nums:
            if num % 2 == 1:
                mod += 1
            mod %= k
            result += count[mod]
            count[mod] += 1

        return result