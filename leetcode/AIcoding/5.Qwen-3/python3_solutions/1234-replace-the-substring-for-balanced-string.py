class Solution:
    def replaceSubstring(self, s: str, sub: str) -> int:
        from collections import defaultdict

        count = defaultdict(int)
        required = defaultdict(int)
        for c in sub:
            required[c] += 1

        window = defaultdict(int)
        formed = 0
        left = 0
        min_len = float('inf')

        for right in range(len(s)):
            c = s[right]
            window[c] += 1

            if window[c] == required[c]:
                formed += 1

            while formed == len(required):
                current_len = right - left + 1
                if current_len < min_len:
                    min_len = current_len

                left_char = s[left]
                window[left_char] -= 1
                if window[left_char] < required[left_char]:
                    formed -= 1
                left += 1

        return min_len if min_len != float('inf') else -1