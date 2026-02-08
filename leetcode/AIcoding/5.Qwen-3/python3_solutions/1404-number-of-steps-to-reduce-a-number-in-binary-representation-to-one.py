class Solution:
    def numSteps(self, s: str) -> int:
        steps = 0
        while len(s) > 1:
            if s[-1] == '1':
                carry = 1
                i = len(s) - 1
                while i >= 0 and carry:
                    if s[i] == '1':
                        s = s[:i] + '0' + s[i+1:]
                    else:
                        s = s[:i] + '1' + s[i+1:]
                        carry = 0
                    i -= 1
                if carry:
                    s = '1' + s
            s = s[:-1]
            steps += 1
        return steps