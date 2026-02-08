class Solution:
    def specialSubstrings(self, s: str, k: int) -> int:
        from collections import defaultdict

        count = 0
        freq = defaultdict(int)
        left = 0

        for right in range(len(s)):
            freq[s[right]] += 1

            while len(freq) > k:
                freq[s[left]] -= 1
                if freq[s[left]] == 0:
                    del freq[s[left]]
                left += 1

            if len(freq) == k:
                count += 1

        return count