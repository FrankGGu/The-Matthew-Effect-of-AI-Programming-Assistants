class Solution:
    def constructRectangle(self, area: int) -> List[int]:
        import math
        max_len = int(math.sqrt(area)) + 1
        for i in range(max_len, 0, -1):
            if area % i == 0:
                return [i, area // i]
        return [1, area]