class Solution:
    def passThePillow(self, n: int, time: int) -> int:
        direction = 1
        current = 0
        for _ in range(time):
            current += direction
            if current == n - 1 or current == 0:
                direction *= -1
        return current