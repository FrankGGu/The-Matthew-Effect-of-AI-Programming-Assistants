class Solution:
    def minOperations(self, s: str) -> int:
        from collections import Counter

        count = Counter(s)
        freq = list(count.values())
        freq.sort(reverse=True)

        res = 0
        for i in range(1, len(freq)):
            if freq[i] >= freq[0]:
                return -1
            res += freq[0] - freq[i]
        return res