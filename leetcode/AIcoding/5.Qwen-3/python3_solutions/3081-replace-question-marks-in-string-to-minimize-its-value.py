class Solution:
    def minimizeStringValue(self, s: str) -> str:
        from collections import Counter

        def count_chars(s):
            return Counter(c for c in s if c.isalpha())

        def get_min_char(counts):
            for c in 'abcdefghijklmnopqrstuvwxyz':
                if counts[c] == 0:
                    return c
            return None

        def get_max_char(counts):
            max_count = 0
            max_char = None
            for c in 'abcdefghijklmnopqrstuvwxyz':
                if counts[c] > max_count:
                    max_count = counts[c]
                    max_char = c
            return max_char

        original_counts = count_chars(s)
        new_chars = []

        for c in s:
            if c == '?':
                min_char = get_min_char(original_counts)
                new_chars.append(min_char)
                original_counts[min_char] += 1
            else:
                new_chars.append(c)

        return ''.join(new_chars)