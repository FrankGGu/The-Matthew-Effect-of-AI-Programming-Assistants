class Solution:
    def minimumTimeToInitialState(self, s: str, k: int) -> int:
        n = len(s)
        for i in range(1, n):
            if s[i:] == s[:-i]:
                return i
        return n