class Solution:
    def minimumDeletions(self, s: str) -> int:
        count = [0] * 26
        for c in s:
            count[ord(c) - ord('a')] += 1
        left = 0
        right = 0
        res = float('inf')
        for i in range(26):
            if i > 0:
                left += count[i-1]
            right = sum(count[i+1:])
            res = min(res, left + right)
        return res