class Solution:
    def countNumbersWithNonDecreasingDigits(self, n: int) -> int:
        from math import comb

        s = str(n)
        m = len(s)
        res = 0

        for i in range(1, m):
            res += comb(9 + i, i)

        digits = [int(c) for c in s]
        for i in range(m):
            for d in range(0, digits[i]):
                if i == 0 or d >= digits[i - 1]:
                    res += comb(9 - d + (m - i - 1), m - i - 1)
            if i > 0 and digits[i] < digits[i - 1]:
                break

        return res