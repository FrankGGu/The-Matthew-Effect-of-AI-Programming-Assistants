class Solution:
    def makeTheIntegerBinary(self, n: int, k: int) -> bool:
        def count_bits(x):
            return bin(x).count('1')

        for i in range(n, max(n - 100, 0), -1):
            if count_bits(i) <= k and i <= n:
                return True
        return False