class Solution:
    def earliestDayOfFullBloom(self, plantTime: List[int], growTime: List[int]) -> int:
        pairs = sorted(zip(plantTime, growTime), key=lambda x: (x[1], x[0]))
        res = 0
        current_day = 0
        for p, g in pairs:
            current_day += p
            res = max(res, current_day + g)
        return res