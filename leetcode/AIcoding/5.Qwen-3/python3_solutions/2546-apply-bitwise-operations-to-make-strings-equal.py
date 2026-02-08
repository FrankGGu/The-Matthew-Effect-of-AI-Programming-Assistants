class Solution:
    def canMakeEqual(self, s: str, target: str) -> bool:
        if len(s) != len(target):
            return False
        for i in range(len(s)):
            if (ord(s[i]) ^ ord(target[i])) & 1:
                return False
        return True