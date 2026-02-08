class Solution:
    def minimumPerimeter(self, needed: int) -> int:
        n = 1
        while True:
            total = (n * (n + 1) // 2) * 2
            if total >= needed:
                return n * 8
            n += 1