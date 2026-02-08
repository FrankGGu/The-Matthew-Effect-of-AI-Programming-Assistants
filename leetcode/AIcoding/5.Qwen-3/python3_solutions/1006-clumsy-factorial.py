class Solution:
    def clumsy(self, N: int) -> int:
        if N == 1:
            return 1
        if N == 2:
            return 2
        if N == 3:
            return 6
        res = N
        i = N - 1
        op = 0
        while i > 0:
            if op % 4 == 0:
                res *= i
            elif op % 4 == 1:
                res //= i
            elif op % 4 == 2:
                res += i
            else:
                res -= i
            i -= 1
            op += 1
        return res