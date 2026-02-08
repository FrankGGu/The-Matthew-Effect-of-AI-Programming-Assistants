class Solution:
    def countGoodNumbers(self, maxTime: int) -> int:
        MOD = 10**9 + 7
        even = pow(5, maxTime, MOD)
        odd = pow(4, maxTime, MOD)
        return (even * odd) % MOD