class Solution:
    def canBeTypedWords(self, text: str, brokenLetters: str) -> int:
        words = text.split()
        broken = set(brokenLetters)
        count = 0
        for word in words:
            if all(c not in broken for c in word):
                count += 1
        return count