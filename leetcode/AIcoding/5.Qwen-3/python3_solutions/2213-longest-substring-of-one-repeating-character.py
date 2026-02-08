class Solution:
    def longestRepeatedCharSubstring(self, s: str) -> int:
        max_len = 0
        left = 0
        count = {}
        for right in range(len(s)):
            count[s[right]] = count.get(s[right], 0) + 1
            while count[s[right]] > 1:
                count[s[left]] -= 1
                if count[s[left]] == 0:
                    del count[s[left]]
                left += 1
            max_len = max(max_len, right - left + 1)
        return max_len