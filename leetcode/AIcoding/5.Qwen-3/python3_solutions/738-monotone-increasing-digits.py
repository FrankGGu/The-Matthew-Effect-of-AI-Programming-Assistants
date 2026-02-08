class Solution:
    def monotoneIncreasingDigits(self, n: int) -> int:
        s = list(str(n))
        i = 0
        while i < len(s) - 1:
            if s[i] > s[i + 1]:
                break
            i += 1
        if i == len(s) - 1:
            return n
        while i >= 0 and s[i] > s[i + 1]:
            s[i] = str(int(s[i]) - 1)
            i -= 1
        for j in range(i + 1, len(s)):
            s[j] = '9'
        return int(''.join(s))