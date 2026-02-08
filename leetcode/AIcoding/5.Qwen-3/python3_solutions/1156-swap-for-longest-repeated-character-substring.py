class Solution:
    def maxRepOptI(self, s: str) -> int:
        from collections import defaultdict

        n = len(s)
        if n == 0:
            return 0

        count = defaultdict(int)
        for c in s:
            count[c] += 1

        res = 0
        i = 0
        while i < n:
            j = i
            while j < n and s[j] == s[i]:
                j += 1
            length = j - i
            if j < n:
                k = j
                while k < n and s[k] == s[i]:
                    k += 1
                if k - j == 1:
                    length += 1
            if length > res:
                res = length
            i = j

        for c in count:
            if count[c] > res:
                res = count[c]

        return res