class Solution:
    def isValidWord(self, word: str) -> bool:
        if len(word) < 2:
            return False
        if not word[0].isalpha() or not word[-1].isalpha():
            return False
        for c in word[1:-1]:
            if not c.isdigit():
                return False
        return True