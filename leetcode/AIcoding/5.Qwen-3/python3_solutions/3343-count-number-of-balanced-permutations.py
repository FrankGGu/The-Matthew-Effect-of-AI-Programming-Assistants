from math import factorial
from collections import Counter

class Solution:
    def numberOfBalancedPermutations(self, s: str) -> int:
        MOD = 10**9 + 7
        cnt = Counter(s)
        total = len(s)
        odd_count = sum(1 for v in cnt.values() if v % 2 != 0)
        if odd_count > 2:
            return 0
        fact = [1] * (total + 1)
        for i in range(1, total + 1):
            fact[i] = fact[i - 1] * i % MOD
        res = fact[total]
        for v in cnt.values():
            res = res * pow(fact[v], MOD - 2, MOD) % MOD
        if odd_count == 0:
            return res
        else:
            return res * pow(2, MOD - 2, MOD) % MOD