class Solution:
    def longestNiceSubstring(self, s: str) -> str:
        def is_nice(sub):
            chars = set(sub)
            for c in chars:
                if c.lower() not in chars or c.upper() not in chars:
                    return False
            return True

        n = len(s)
        max_len = 0
        result = ""
        for i in range(n):
            for j in range(i + 1, n + 1):
                substr = s[i:j]
                if is_nice(substr) and len(substr) > max_len:
                    max_len = len(substr)
                    result = substr
        return result