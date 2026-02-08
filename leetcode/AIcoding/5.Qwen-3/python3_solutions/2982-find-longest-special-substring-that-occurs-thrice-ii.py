class Solution:
    def maximumLength(self, s: str) -> int:
        from collections import defaultdict

        def get_substrings(s):
            n = len(s)
            substrings = defaultdict(int)
            for i in range(n):
                current_char = s[i]
                length = 0
                for j in range(i, n):
                    if s[j] == current_char:
                        length += 1
                        substrings[(current_char, length)] += 1
                    else:
                        break
            return substrings

        substrings = get_substrings(s)
        max_len = -1
        for (char, length), count in substrings.items():
            if count >= 3:
                max_len = max(max_len, length)
        return max_len