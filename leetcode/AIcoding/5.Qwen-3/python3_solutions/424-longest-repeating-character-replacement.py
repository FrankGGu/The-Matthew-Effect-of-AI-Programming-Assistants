class Solution:
    def characterReplacement(self, s: str, k: int) -> int:
        from collections import defaultdict

        count = defaultdict(int)
        max_length = 0
        left = 0
        max_count = 0

        for right in range(len(s)):
            count[s[right]] += 1
            max_count = max(max_count, count[s[right]])

            while right - left + 1 - max_count > k:
                count[s[left]] -= 1
                left += 1

            max_length = max(max_length, right - left + 1)

        return max_length