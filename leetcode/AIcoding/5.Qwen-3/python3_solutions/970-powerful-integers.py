class Solution:
    def powerfulIntegers(self, x: int, y: int, bound: int) -> List[int]:
        result = set()
        for i in range(0, 21):
            for j in range(0, 21):
                val = x**i + y**j
                if val <= bound:
                    result.add(val)
                else:
                    break
            if x == 1 and i > 0:
                break
        return list(result)