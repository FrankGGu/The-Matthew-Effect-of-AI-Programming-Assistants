class Solution:
    def maxNumberOfGroups(self, grades: List[int]) -> int:
        grades.sort()
        count = 0
        prev = -1
        for g in grades:
            if g > prev:
                count += 1
                prev = g
        return count