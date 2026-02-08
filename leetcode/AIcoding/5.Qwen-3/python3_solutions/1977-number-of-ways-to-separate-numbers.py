class Solution:
    def numberOfWays(self, s: str) -> int:
        n = len(s)
        left = [0] * n
        right = [0] * n
        zeros = 0
        ones = 0
        for i in range(n):
            left[i] = ones
            if s[i] == '0':
                zeros += 1
            else:
                ones += 1
        zeros = 0
        ones = 0
        for i in range(n - 1, -1, -1):
            right[i] = ones
            if s[i] == '0':
                zeros += 1
            else:
                ones += 1
        res = 0
        for i in range(n):
            if s[i] == '0':
                res += left[i] * right[i]
            else:
                res += left[i] * right[i]
        return res