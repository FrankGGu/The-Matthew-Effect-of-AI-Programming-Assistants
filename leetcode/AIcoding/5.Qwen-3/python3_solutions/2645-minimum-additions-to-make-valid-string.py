class Solution:
    def minAdditions(self, s: str) -> int:
        res = 0
        depth = 0
        for c in s:
            if c == '(':
                depth += 1
            else:
                depth -= 1
                if depth < 0:
                    res += 1
                    depth = 0
        return res + depth