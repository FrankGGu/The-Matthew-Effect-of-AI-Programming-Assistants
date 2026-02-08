class Solution:
    def decodeMessage(self, key: str, message: str) -> str:
        mapping = {}
        current_char = 'a'
        for c in key:
            if c not in mapping and c != ' ':
                mapping[c] = current_char
                current_char = chr(ord(current_char) + 1)
        result = []
        for c in message:
            if c == ' ':
                result.append(' ')
            else:
                result.append(mapping[c])
        return ''.join(result)