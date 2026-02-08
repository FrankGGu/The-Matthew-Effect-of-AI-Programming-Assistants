class Solution:
    def minDeletions(self, s: str, k: int) -> int:
        from collections import Counter

        count = Counter(s)
        freq = [0] * 26

        for ch in count:
            freq[ord(ch) - ord('a')] = count[ch]

        freq.sort(reverse=True)

        res = 0
        for i in range(1, 26):
            if freq[i] == 0:
                continue
            while freq[i] > 0 and (freq[i] - freq[i-1] > k or freq[i] < freq[i-1] - k):
                freq[i] -= 1
                res += 1
        return res