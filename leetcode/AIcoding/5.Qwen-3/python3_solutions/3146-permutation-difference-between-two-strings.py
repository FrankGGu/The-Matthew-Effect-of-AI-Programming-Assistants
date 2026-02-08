class Solution:
    def permutationDifference(self, s: str, t: str) -> int:
        pos = [0] * 26
        for i, c in enumerate(s):
            pos[ord(c) - ord('a')] = i
        res = 0
        for i, c in enumerate(t):
            res += abs(pos[ord(c) - ord('a')] - i)
        return res