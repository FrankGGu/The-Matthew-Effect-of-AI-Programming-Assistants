class Solution:
    def checkStr(self, s: str) -> bool:
        foundB = False
        for char in s:
            if char == 'b':
                foundB = True
            elif char == 'a' and foundB:
                return False
        return True