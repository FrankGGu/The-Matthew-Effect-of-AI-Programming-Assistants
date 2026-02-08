class Solution:
    def bestCoordinate(self, towerQuality: List[List[int]]) -> List[int]:
        from collections import defaultdict

        maxQuality = 0
        result = [0, 0]

        for x in range(101):
            for y in range(101):
                total = 0
                for tx, ty, q in towerQuality:
                    dx = abs(x - tx)
                    dy = abs(y - ty)
                    if dx + dy <= 2:
                        total += q
                if total > maxQuality:
                    maxQuality = total
                    result = [x, y]
        return result