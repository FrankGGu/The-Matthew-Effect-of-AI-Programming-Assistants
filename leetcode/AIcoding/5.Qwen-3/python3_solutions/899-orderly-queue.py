class Solution:
    def orderlyQueue(self, s: str, k: int) -> str:
        if k == 1:
            min_s = s
            for i in range(len(s)):
                rotated = s[i:] + s[:i]
                if rotated < min_s:
                    min_s = rotated
            return min_s
        else:
            return ''.join(sorted(s))