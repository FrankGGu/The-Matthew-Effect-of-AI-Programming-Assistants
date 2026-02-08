class Solution:
    def totalMoney(self, n: int) -> int:
        total = 0
        for i in range(n):
            week = i // 7
            day = i % 7
            total += 1 + week + day
        return total