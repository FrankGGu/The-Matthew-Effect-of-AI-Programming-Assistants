class Solution:
    def strTransform(self, s: str, t: str) -> bool:
        if len(s) != len(t):
            return False
        count = [0] * 256
        for char in s:
            count[ord(char)] += 1
        for char in t:
            count[ord(char)] -= 1
        for i in range(256):
            if count[i] != 0:
                return False
        return True