class Solution:
    def sumSubseqWidths(self, A: List[int]) -> int:
        A.sort()
        n = len(A)
        mod = 10**9 + 7
        res = 0
        for i in range(n):
            res = (res + A[i] * (pow(2, i, mod) - pow(2, n - i - 1, mod))) % mod
        return res