class Solution:
    def addRungs(self, rungs: List[int], dist: int) -> int:
        prev = 0
        count = 0
        for r in rungs:
            if r - prev > dist:
                count += (r - prev - 1) // dist
            prev = r
        return count