class Solution:
    def reverseDegree(self, s: str) -> int:
        count = {}
        for c in s:
            count[c] = count.get(c, 0) + 1
        max_freq = max(count.values())
        return max_freq