class Solution:
    def shortestPalindrome(self, s: str) -> str:
        i = 0
        n = len(s)
        for j in range(n - 1, -1, -1):
            if s[i] == s[j]:
                i += 1
        if i == n:
            return s
        suffix = s[i:]
        return suffix[::-1] + self.shortestPalindrome(s[:n - len(suffix)]) + suffix