class Solution:
    def longestHappyPrefix(self, s: str) -> int:
        n = len(s)
        lps = [0] * n
        length = 0
        for i in range(1, n):
            while length > 0 and s[i] != s[length]:
                length = lps[length - 1]
            if s[i] == s[length]:
                length += 1
                lps[i] = length
            else:
                lps[i] = 0
        return lps[-1]