class Solution:
    def uniqueLetterString(self, s: str) -> int:
        from collections import defaultdict

        pos = defaultdict(list)
        for i, c in enumerate(s):
            pos[c].append(i)

        res = 0
        for indices in pos.values():
            n = len(indices)
            for i in range(n):
                left = indices[i] - (indices[i-1] if i > 0 else -1)
                right = (indices[i+1] if i < n-1 else len(s)) - indices[i]
                res += left * right
        return res