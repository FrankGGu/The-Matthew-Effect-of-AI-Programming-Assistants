class Solution:
    def largestSubstringBetweenTwoEqualCharacters(self, s: str) -> int:
        first = {}
        last = {}
        for i, c in enumerate(s):
            if c not in first:
                first[c] = i
            last[c] = i
        max_len = -1
        for c in first:
            max_len = max(max_len, last[c] - first[c] - 1)
        return max_len