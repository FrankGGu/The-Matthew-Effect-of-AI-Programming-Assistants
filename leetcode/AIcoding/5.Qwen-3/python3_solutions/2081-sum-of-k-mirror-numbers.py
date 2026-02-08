class Solution:
    def kMirror(self, k: int, n: int) -> int:
        def is_kmirror(num, k):
            s = ""
            while num > 0:
                s += str(num % k)
                num //= k
            return s == s[::-1]

        res = 0
        count = 0
        i = 1
        while count < n:
            s = str(i)
            if s == s[::-1]:
                if is_kmirror(i, k):
                    res += i
                    count += 1
            i += 1
        return res