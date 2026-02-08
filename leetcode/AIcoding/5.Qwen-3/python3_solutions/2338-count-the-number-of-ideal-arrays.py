class Solution:
    def idealArrays(self, n: int, x: int) -> int:
        from math import comb
        from collections import defaultdict

        def get_factors(num):
            factors = set()
            for i in range(1, int(num**0.5) + 1):
                if num % i == 0:
                    factors.add(i)
                    factors.add(num // i)
            return factors

        MOD = 10**9 + 7

        factors = get_factors(x)
        dp = [0] * (n + 1)
        dp[0] = 1

        for factor in factors:
            for i in range(n, factor - 1, -1):
                dp[i] = (dp[i] + dp[i - factor]) % MOD

        result = 0
        for i in range(1, n + 1):
            result = (result + dp[i]) % MOD

        return result