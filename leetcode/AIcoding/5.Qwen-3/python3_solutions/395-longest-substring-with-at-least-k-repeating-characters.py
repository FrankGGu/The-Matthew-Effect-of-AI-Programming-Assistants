class Solution:
    def longestSubstring(self, s: str, k: int) -> int:
        if len(s) < k:
            return 0
        from collections import Counter
        count = Counter(s)
        for i in range(len(s)):
            if count[s[i]] < k:
                return max(self.longestSubstring(s[:i], k), self.longestSubstring(s[i+1:], k))
        return len(s)