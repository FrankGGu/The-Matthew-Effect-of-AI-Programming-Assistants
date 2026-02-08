class Solution:
    def minAnagramLength(self, s: str) -> int:
        from collections import Counter

        n = len(s)
        for k in range(1, n + 1):
            if n % k != 0:
                continue
            cnt = Counter(s[:k])
            valid = True
            for i in range(k, n, k):
                if Counter(s[i:i + k]) != cnt:
                    valid = False
                    break
            if valid:
                return k
        return n