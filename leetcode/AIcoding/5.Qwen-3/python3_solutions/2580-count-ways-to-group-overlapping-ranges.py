class Solution:
    def countGroups(self, ranges: List[List[int]]) -> int:
        ranges.sort()
        groups = 0
        i = 0
        while i < len(ranges):
            j = i + 1
            while j < len(ranges) and ranges[j][0] <= ranges[i][1]:
                ranges[i][1] = max(ranges[i][1], ranges[j][1])
                j += 1
            groups += 1
            i = j
        return groups