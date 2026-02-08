class Solution:
    def countPossibleSubstrings(self, s: str) -> int:
        from collections import Counter

        def is_valid(count):
            return all(v >= 1 for v in count.values())

        n = len(s)
        result = 0
        for i in range(n):
            count = Counter()
            for j in range(i, n):
                count[s[j]] += 1
                if is_valid(count):
                    result += 1
        return result