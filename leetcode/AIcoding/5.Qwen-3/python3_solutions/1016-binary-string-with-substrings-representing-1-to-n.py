class Solution:
    def queryString(self, s: str, n: int) -> bool:
        seen = set()
        for i in range(len(s)):
            if s[i] == '0':
                continue
            num = 0
            for j in range(i, len(s)):
                num = num * 2 + (ord(s[j]) - ord('0'))
                if num > n:
                    break
                seen.add(num)
        for i in range(1, n + 1):
            if i not in seen:
                return False
        return True