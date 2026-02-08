class Solution:
    def sumOfFlooredPairs(self, nums: List[int]) -> int:
        from collections import Counter
        MOD = 10**9 + 7
        max_num = max(nums)
        count = Counter(nums)
        res = 0
        for x in count:
            for k in range(1, max_num // x + 1):
                lower = k * x
                upper = (k + 1) * x - 1
                if upper > max_num:
                    upper = max_num
                res += count[x] * (count[upper] if upper in count else 0)
                res %= MOD
        return res