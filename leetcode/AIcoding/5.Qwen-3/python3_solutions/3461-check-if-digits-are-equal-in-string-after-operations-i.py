class Solution:
    def areDigitsEqual(self, s: str) -> bool:
        count = {}
        for c in s:
            count[c] = count.get(c, 0) + 1
        values = list(count.values())
        return all(v == values[0] for v in values)