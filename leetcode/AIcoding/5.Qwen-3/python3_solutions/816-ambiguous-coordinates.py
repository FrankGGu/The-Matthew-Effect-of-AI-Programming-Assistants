class Solution:
    def ambiguousCoordinates(self, s: str) -> List[str]:
        def generate(s):
            res = []
            if len(s) == 1:
                res.append(s)
                return res
            if s[0] != '0':
                res.append(s)
            for i in range(1, len(s)):
                if s[0] != '0' or i > 1:
                    res.append(s[:i] + '.' + s[i:])
            return res

        s = s[1:-1]
        result = []
        for i in range(1, len(s)):
            left = generate(s[:i])
            right = generate(s[i:])
            for l in left:
                for r in right:
                    result.append('(' + l + ', ' + r + ')')
        return result