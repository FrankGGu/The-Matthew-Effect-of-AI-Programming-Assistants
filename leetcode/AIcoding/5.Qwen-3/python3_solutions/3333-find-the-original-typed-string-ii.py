class Solution:
    def findOriginalString(self, s: str) -> str:
        from collections import defaultdict

        def decode(s):
            stack = []
            num = 0
            curr = ""
            for c in s:
                if c.isdigit():
                    num = num * 10 + int(c)
                elif c == '[':
                    stack.append((curr, num))
                    curr = ""
                    num = 0
                elif c == ']':
                    prev, n = stack.pop()
                    curr = prev + curr * n
                else:
                    curr += c
            return curr

        res = []
        i = 0
        while i < len(s):
            if s[i].isdigit():
                j = i
                while j < len(s) and s[j].isdigit():
                    j += 1
                k = j
                while k < len(s) and s[k] != ']':
                    k += 1
                if k < len(s):
                    part = s[i:j]
                    encoded = s[j+1:k]
                    decoded = decode(encoded)
                    res.append(decoded)
                    i = k + 1
                else:
                    i += 1
            else:
                res.append(s[i])
                i += 1
        return ''.join(res)