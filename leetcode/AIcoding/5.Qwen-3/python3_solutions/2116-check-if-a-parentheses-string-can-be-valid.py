class Solution:
    def canBeValid(self, s: str) -> bool:
        if len(s) % 2 != 0:
            return False
        open_count = 0
        close_count = 0
        for char in s:
            if char == '(':
                open_count += 1
            else:
                close_count += 1
            if open_count < close_count:
                return False
        return open_count == close_count