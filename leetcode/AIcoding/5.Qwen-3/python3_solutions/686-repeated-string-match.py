class Solution:
    def repeatedStringMatch(self, a: str, b: str) -> int:
        if len(a) < len(b):
            repeat = (len(b) + len(a) - 1) // len(a)
        else:
            repeat = 1
        for i in range(1, repeat + 2):
            if b in a * i:
                return i
        return -1