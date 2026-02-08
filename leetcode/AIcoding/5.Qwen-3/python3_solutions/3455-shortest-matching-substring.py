class Solution:
    def shortestSubstrings(self, s: str, words: list[str]) -> str:
        from collections import defaultdict

        word_set = set(words)
        n = len(s)
        min_len = float('inf')
        result = ""

        for i in range(n):
            for j in range(i + 1, n + 1):
                substring = s[i:j]
                if substring in word_set:
                    if len(substring) < min_len:
                        min_len = len(substring)
                        result = substring
        return result