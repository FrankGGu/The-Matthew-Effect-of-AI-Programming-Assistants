class Solution:
    def numberOfBurgers(self, tomatoSize: int, cheeseSize: int) -> List[int]:
        for x in range(0, tomatoSize // 2 + 1):
            y = cheeseSize - x
            if 2 * x + 3 * y == tomatoSize and y >= 0:
                return [x, y]
        return []