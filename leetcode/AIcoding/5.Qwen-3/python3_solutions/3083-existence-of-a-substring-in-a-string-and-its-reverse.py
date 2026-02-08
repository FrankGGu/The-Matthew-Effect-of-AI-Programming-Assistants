class Solution:
    def isSubstringPresent(self, s: str) -> bool:
        reversed_s = s[::-1]
        for i in range(len(s)):
            for j in range(i + 1, len(s) + 1):
                substring = s[i:j]
                if substring in reversed_s:
                    return True
        return False