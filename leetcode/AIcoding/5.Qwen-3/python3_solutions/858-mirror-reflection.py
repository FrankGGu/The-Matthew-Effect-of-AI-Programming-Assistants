class Solution:
    def mirrorReflection(self, p: int, q: int) -> int:
        from math import gcd

        g = gcd(p, q)
        p //= g
        q //= g

        if p % 2 == 0:
            return 2
        elif q % 2 == 0:
            return 1
        else:
            return 0