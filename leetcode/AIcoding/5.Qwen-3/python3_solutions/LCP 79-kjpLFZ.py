class Solution:
    def getEncryptedData(self, s: str, k: int) -> str:
        result = []
        for i in range(len(s)):
            if s[i] == 'a':
                result.append('z')
            elif s[i] == 'A':
                result.append('Z')
            else:
                result.append(chr(ord(s[i]) - 1))
        return ''.join(result)