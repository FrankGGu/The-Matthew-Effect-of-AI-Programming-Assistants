class Solution:
    def pow(self, x: int, n: int, mod: int) -> int:
        result = 1
        x = x % mod
        while n > 0:
            if n % 2 == 1:
                result = (result * x) % mod
            x = (x * x) % mod
            n = n // 2
        return result