class Solution:
    def maxNiceDivisors(self, n: int) -> int:
        MOD = 10**9 + 7
        if n == 1:
            return 1
        if n == 2:
            return 2
        if n == 3:
            return 3
        a = n // 3
        b = n % 3
        if b == 0:
            return pow(3, a, MOD)
        elif b == 1:
            return pow(3, a - 1, MOD) * 4 % MOD
        else:
            return pow(3, a, MOD) * 2 % MOD