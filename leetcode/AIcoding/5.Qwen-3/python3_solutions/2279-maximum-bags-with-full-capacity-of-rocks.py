class Solution:
    def maximumBags(self, capacity: list[int], rocks: list[int], additionalRocks: int) -> int
        diff = [c - r for c, r in zip(capacity, rocks)]
        diff.sort()
        count = 0
        for d in diff:
            if d <= 0:
                count += 1
            else:
                if additionalRocks >= d:
                    additionalRocks -= d
                    count += 1
                else:
                    break
        return count