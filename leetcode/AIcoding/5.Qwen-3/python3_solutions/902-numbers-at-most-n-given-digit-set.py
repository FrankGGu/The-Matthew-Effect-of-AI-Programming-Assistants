class Solution:
    def atMostNGivenDigitSet(self, digits: List[str], n: int) -> int:
        s = str(n)
        n_len = len(s)
        res = 0
        for i in range(1, n_len):
            res += len(digits) ** i
        for i in range(n_len):
            found = False
            for d in digits:
                if d < s[i]:
                    res += len(digits) ** (n_len - i - 1)
                elif d == s[i]:
                    found = True
            if not found:
                return res
        return res + 1