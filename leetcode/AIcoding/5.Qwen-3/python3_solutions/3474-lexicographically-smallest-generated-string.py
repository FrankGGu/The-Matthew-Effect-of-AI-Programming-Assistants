class Solution:
    def getSmallestString(self, n: int, k: int) -> str:
        s = ['a'] * n
        k -= n
        i = n - 1
        while k > 0:
            add = min(k, 25)
            s[i] = chr(ord('a') + add)
            k -= add
            i -= 1
        return ''.join(s)