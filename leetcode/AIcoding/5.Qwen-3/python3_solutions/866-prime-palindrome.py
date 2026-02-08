class Solution:
    def primePalindrome(self, n: int) -> int:
        def is_prime(x):
            if x < 2:
                return False
            if x == 2:
                return True
            if x % 2 == 0:
                return False
            for i in range(3, int(x**0.5) + 1, 2):
                if x % i == 0:
                    return False
            return True

        if n <= 2:
            return 2

        for l in range(1, 6):
            for first_half in range(10**(l-1), 10**l):
                s = str(first_half)
                if l == 1:
                    candidate = int(s)
                else:
                    candidate = int(s + s[-2::-1])
                if candidate >= n and is_prime(candidate):
                    return candidate

        for i in range(11, 100000, 2):
            if is_prime(i):
                return i