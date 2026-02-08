class Solution:
    def shiftDistance(self, s: str, t: str, k: int) -> bool:
        if len(s) != len(t):
            return False
        n = len(s)
        for i in range(n):
            diff = (ord(t[i]) - ord(s[i])) % 26
            if diff != 0 and diff != k % 26:
                return False
        return True