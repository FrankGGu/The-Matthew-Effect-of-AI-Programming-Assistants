class Solution:
    def earliestSecond(self, s: str) -> int:
        from collections import defaultdict

        pos = defaultdict(list)
        for i, c in enumerate(s):
            pos[c].append(i)

        res = 0
        for c in pos:
            if len(pos[c]) > 1:
                res = max(res, pos[c][1] - pos[c][0])
        return res