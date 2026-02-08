class Solution:
    def findNthDigit(self, n: int) -> int:
        i = 1
        count = 9
        while n > i * count:
            n -= i * count
            i += 1
            count *= 10
        return int(str(10 ** (i - 1) + (n - 1) // i))