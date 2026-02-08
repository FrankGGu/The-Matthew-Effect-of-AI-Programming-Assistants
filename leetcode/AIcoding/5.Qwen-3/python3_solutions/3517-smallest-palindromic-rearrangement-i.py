class Solution:
    def primePalindrome(self, n: int) -> int:
        def is_prime(x):
            if x < 2:
                return False
            for i in range(2, int(x**0.5) + 1):
                if x % i == 0:
                    return False
            return True

        def is_palindrome(x):
            return str(x) == str(x)[::-1]

        if n <= 2:
            return 2
        if n <= 3:
            return 3
        if n <= 5:
            return 5
        if n <= 7:
            return 7

        for k in range(1, 100000):
            s = str(k)
            candidate = int(s + s[-2::-1])
            if candidate >= n and is_prime(candidate):
                return candidate
            candidate = int(s + s[-1::-1])
            if candidate >= n and is_prime(candidate):
                return candidate