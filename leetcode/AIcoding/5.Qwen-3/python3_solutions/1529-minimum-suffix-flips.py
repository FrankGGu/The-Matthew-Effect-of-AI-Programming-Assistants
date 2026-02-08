class Solution:
    def minSuffixFlips(self, s: str) -> int:
        res = 0
        prev = '0'
        for c in s:
            if c != prev:
                res += 1
                prev = c
        return res