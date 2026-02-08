class Solution:
    def isStrictlyPalindromic(self, n: int) -> bool:
        def is_palindrome(s):
            return s == s[::-1]

        for base in range(2, n - 1):
            num = ""
            x = n
            while x > 0:
                num = str(x % base) + num
                x //= base
            if not is_palindrome(num):
                return False
        return True