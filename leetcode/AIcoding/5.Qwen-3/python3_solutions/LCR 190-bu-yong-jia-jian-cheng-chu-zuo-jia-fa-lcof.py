class Solution:
    def encrypt(self, s: str) -> str:
        result = []
        for char in s:
            if 'a' <= char <= 'z':
                result.append(chr(ord('z') - ord(char) + ord('a')))
            elif 'A' <= char <= 'Z':
                result.append(chr(ord('Z') - ord(char) + ord('A')))
            else:
                result.append(char)
        return ''.join(result)