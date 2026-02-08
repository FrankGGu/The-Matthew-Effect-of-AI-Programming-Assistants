class Solution:
    def oddEven(self, s: str) -> int:
        count = 0
        for c in s:
            if ord(c) % 2 == 1:
                count += 1
        return count