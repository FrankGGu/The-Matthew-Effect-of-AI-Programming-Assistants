class Solution:
    def integerReplacement(self, n: int) -> int:
        count = 0
        while n > 1:
            if n % 2 == 0:
                n //= 2
            else:
                if n == 1:
                    break
                if (n & 1) and (n >> 1) % 2 == 1 and n != 3:
                    n += 1
                else:
                    n -= 1
            count += 1
        return count