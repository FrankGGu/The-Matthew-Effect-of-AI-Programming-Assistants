class Solution:
    def smallestSubstring(self, s: str) -> str:
        from collections import defaultdict

        char_count = defaultdict(int)
        left = 0
        min_length = float('inf')
        result = ""

        for right in range(len(s)):
            char_count[s[right]] += 1

            while len(char_count) > 2:
                char_count[s[left]] -= 1
                if char_count[s[left]] == 0:
                    del char_count[s[left]]
                left += 1

            if len(char_count) == 2:
                current_length = right - left + 1
                if current_length < min_length:
                    min_length = current_length
                    result = s[left:right+1]

        return result