class Solution:
    def maxFreq(self, s: str, power: int, k: int, limit: int) -> int:
        from collections import defaultdict

        n = len(s)
        max_freq = 0
        freq = defaultdict(int)
        left = 0

        for right in range(n):
            freq[s[right]] += 1
            while (right - left + 1) - max(freq.values()) > k:
                freq[s[left]] -= 1
                if freq[s[left]] == 0:
                    del freq[s[left]]
                left += 1
            max_freq = max(max_freq, max(freq.values()))

        return max_freq