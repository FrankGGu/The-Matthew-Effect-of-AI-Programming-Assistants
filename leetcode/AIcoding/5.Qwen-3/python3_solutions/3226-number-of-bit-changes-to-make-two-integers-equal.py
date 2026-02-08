class Solution:
    def minChanges(self, n: int, goal: int) -> int:
        xor = n ^ goal
        count = 0
        while xor:
            count += xor & 1
            xor >>= 1
        return count