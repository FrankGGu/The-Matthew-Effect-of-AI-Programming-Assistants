class Solution:
    def minCharacters(self, a: str, b: str) -> int:
        from collections import Counter

        count_a = Counter(a)
        count_b = Counter(b)

        def get_min_changes(target_char, count_dict):
            return sum(1 for c in count_dict if c != target_char)

        min_changes = float('inf')

        for c in 'abcdefghijklmnopqrstuvwxyz':
            changes_a = get_min_changes(c, count_a)
            changes_b = get_min_changes(c, count_b)
            min_changes = min(min_changes, changes_a + changes_b)

        for i in range(1, 26):
            c = chr(ord('a') + i)
            prev_c = chr(ord('a') + i - 1)
            if count_a[prev_c] > 0 and count_b[c] > 0:
                min_changes = min(min_changes, len(a) - count_a[prev_c] + len(b) - count_b[c])

        for i in range(24):
            c = chr(ord('a') + i)
            next_c = chr(ord('a') + i + 1)
            if count_a[c] > 0 and count_b[next_c] > 0:
                min_changes = min(min_changes, len(a) - count_a[c] + len(b) - count_b[next_c])

        return min_changes