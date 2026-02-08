class Solution:
    def countGoodNumbers(self, maxTotal: int) -> int:
        MOD = 10**9 + 7
        even_count = (maxTotal + 1) // 2
        odd_count = maxTotal // 2
        return pow(5, even_count, MOD) * pow(4, odd_count, MOD) % MOD