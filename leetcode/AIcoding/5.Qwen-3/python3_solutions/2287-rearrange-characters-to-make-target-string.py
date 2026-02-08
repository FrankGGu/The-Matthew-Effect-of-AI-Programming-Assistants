class Solution:
    def rearrangeCharacters(self, s: str, target: str) -> int:
        from collections import Counter

        count_s = Counter(s)
        count_target = Counter(target)

        min_count = float('inf')

        for char in count_target:
            if char not in count_s:
                return 0
            min_count = min(min_count, count_s[char] // count_target[char])

        return min_count