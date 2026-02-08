class Solution:
    def minOperations(self, nums: List[int], k: int) -> int:
        from collections import defaultdict

        prefix_mod = 0
        mod_count = defaultdict(int)
        mod_count[0] = 1
        result = 0

        for num in nums:
            prefix_mod = (prefix_mod + num) % k
            result += mod_count[(prefix_mod - k) % k]
            mod_count[prefix_mod] += 1

        return result