class Solution:
    def numberOfWays(self, n: int, m: int) -> int:
        MOD = 10**9 + 7
        if n == 1 or m == 1:
            return 0
        if n == 2 or m == 2:
            return (min(n, m) - 2) * (min(n, m) - 1) // 2 % MOD
        return (n - 2) * (m - 2) % MOD