class Solution:
    def reformatNumber(self, number: str) -> str:
        digits = [c for c in number if c.isdigit()]
        n = len(digits)
        res = []
        i = 0
        while i < n:
            if n - i == 4:
                res.extend(digits[i:i+2])
                res.append(' ')
                res.extend(digits[i+2:i+4])
                i += 4
            else:
                res.extend(digits[i:i+3])
                if i + 3 < n:
                    res.append(' ')
                i += 3
        return ''.join(res)