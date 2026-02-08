class Solution:
    def fractionAddition(self, fractions: str) -> str:
        from math import gcd

        def compute_gcd(a, b):
            return gcd(a, b)

        def add_fractions(frac1, frac2):
            a, b = map(int, frac1.split('/'))
            c, d = map(int, frac2.split('/'))
            numerator = a * d + c * b
            denominator = b * d
            common_divisor = compute_gcd(numerator, denominator)
            return f"{numerator // common_divisor}/{denominator // common_divisor}"

        fractions_list = fractions.split('+')
        result = fractions_list[0]
        for i in range(1, len(fractions_list)):
            result = add_fractions(result, fractions_list[i])
        return result