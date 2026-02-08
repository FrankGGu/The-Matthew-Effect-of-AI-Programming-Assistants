class Solution:
    def reverseOnlyLetters(self, S: str) -> str:
        letters = [c for c in S if c.isalpha()]
        result = []
        for c in S:
            if c.isalpha():
                result.append(letters.pop())
            else:
                result.append(c)
        return ''.join(result)