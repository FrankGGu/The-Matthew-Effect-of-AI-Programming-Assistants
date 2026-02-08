class Solution:
    def secondsToRemoveOccurrences(self, s: str) -> int:
        n = len(s)
        left = 0
        right = 0
        res = 0
        while right < n:
            if s[right] == '1':
                left += 1
            else:
                res += left
            right += 1
        return res