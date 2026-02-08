class Solution:
    def findMissingAndRepeatedValues(self, n: int, m: int, grid: List[List[int]]) -> List[int]:
        seen = set()
        repeated = -1
        for row in grid:
            for num in row:
                if num in seen:
                    repeated = num
                else:
                    seen.add(num)
        for i in range(1, n * m + 1):
            if i not in seen:
                return [i, repeated]
        return [-1, repeated]