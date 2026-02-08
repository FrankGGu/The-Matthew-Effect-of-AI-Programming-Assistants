class Solution:
    def minOperations(self, n: int) -> int:
        operations = 0
        while n > 0:
            if n % 2 == 0:
                n //= 2
            else:
                n -= 1
            operations += 1
        return operations