class Solution:
    def longestValidSubstring(self, s: str) -> int:
        max_len = 0
        last = {}
        left = 0
        for right in range(len(s)):
            if s[right] in last and last[s[right]] >= left:
                left = last[s[right]] + 1
            last[s[right]] = right
            max_len = max(max_len, right - left + 1)
        return max_len