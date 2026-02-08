class Solution:
    def getCommonString(self, s1: str, s2: str) -> str:
        i = j = 0
        result = []
        while i < len(s1) and j < len(s2):
            if s1[i] == s2[j]:
                result.append(s1[i])
                i += 1
                j += 1
            elif s1[i] < s2[j]:
                i += 1
            else:
                j += 1
        return ''.join(result)

    def canBeEqual(self, s: str, t: str) -> bool:
        common = self.getCommonString(s, t)
        return common == s and common == t