class Solution:
    def pivotInteger(self, n: int) -> int:
        total = n * (n + 1) // 2
        s = 0
        for i in range(1, n + 1):
            s += i
            if s == total - s + i:
                return i
        return -1