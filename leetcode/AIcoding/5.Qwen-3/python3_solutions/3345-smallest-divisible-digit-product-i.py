class Solution:
    def smallestDivisible(self, n: int) -> int:
        for i in range(1, 10**6):
            product = 1
            for c in str(i):
                product *= int(c)
            if product % n == 0:
                return i
        return -1