class Solution:
    def countTestedDevices(self, s: str) -> int:
        count = 0
        for c in s:
            if c == 'D':
                count += 1
        return count