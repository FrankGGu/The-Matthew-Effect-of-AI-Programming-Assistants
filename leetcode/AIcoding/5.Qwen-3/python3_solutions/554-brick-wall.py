class Solution:
    def leastBricks(self, wall):
        from collections import defaultdict

        count = defaultdict(int)
        for row in wall:
            pos = 0
            for brick in row[:-1]:
                pos += brick
                count[pos] += 1
        return len(wall) - max(count.values()) if count else len(wall)