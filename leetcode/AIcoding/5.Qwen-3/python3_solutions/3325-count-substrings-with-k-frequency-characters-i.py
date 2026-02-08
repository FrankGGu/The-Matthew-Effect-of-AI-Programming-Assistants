class Solution:
    def kFrequencyCharacters(self, s: str, k: int) -> int:
        from collections import Counter

        n = len(s)
        count = 0

        for i in range(n):
            freq = Counter()
            for j in range(i, n):
                freq[s[j]] += 1
                if all(v >= k for v in freq.values()):
                    count += 1

        return count