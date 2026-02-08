class Solution:
    def divide(self, dividend: int, divisor: int) -> int:
        if dividend == -2147483648 and divisor == -1:
            return 2147483647
        sign = -1 if (dividend < 0) ^ (divisor < 0) else 1
        dividend, divisor = abs(dividend), abs(divisor)
        res = 0
        while dividend >= divisor:
            temp = divisor
            i = 0
            while dividend >= temp:
                temp <<= 1
                i += 1
            temp >>= 1
            i -= 1
            dividend -= temp
            res += 1 << i
        return res * sign