class Solution:
    def superPow(self, a: int, b: int) -> int:
        def helper(a, b):
            if b == 0:
                return 1
            if b % 2 == 0:
                return (helper(a, b // 2) ** 2) % 1337
            else:
                return (a * helper(a, b - 1)) % 1337
        return helper(a, b)