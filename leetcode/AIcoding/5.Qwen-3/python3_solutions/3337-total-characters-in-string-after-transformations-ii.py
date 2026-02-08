class Solution:
    def numberOfSpecialChars(self, word: str) -> int:
        lower = [0] * 26
        upper = [0] * 26
        for c in word:
            if 'a' <= c <= 'z':
                lower[ord(c) - ord('a')] += 1
            else:
                upper[ord(c) - ord('A')] += 1
        res = 0
        for i in range(26):
            if lower[i] > 0 and upper[i] > 0:
                res += 1
        return res