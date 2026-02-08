class Solution:
    def rotatedDigits(self, N: int) -> int:
        invalid = {'3', '4', '7'}
        valid = {'2', '5', '6', '9'}
        count = 0
        for i in range(1, N + 1):
            s = str(i)
            if any(c in invalid for c in s):
                continue
            if any(c in valid for c in s):
                count += 1
        return count