class Solution:
    def canConstruct(self, s: str, k: int) -> bool:
        if len(s) < k:
            return False
        count = [0] * 26
        for c in s:
            count[ord(c) - ord('a')] += 1
        odd = sum(1 for c in count if c % 2 != 0)
        return odd <= k