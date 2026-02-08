class Solution:
    def countAnagrams(self, s: str) -> int:
        from math import factorial
        MOD = 10**9 + 7

        def comb(n, k):
            return factorial(n) * pow(factorial(k), MOD - 2, MOD) % MOD * pow(factorial(n - k), MOD - 2, MOD) % MOD

        res = 1
        count = {}
        for c in s:
            count[c] = count.get(c, 0) + 1
        for v in count.values():
            res = res * factorial(v) % MOD
        return res