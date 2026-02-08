class Solution:
    def numberOfSpecialChars(self, word: str) -> int:
        seen = set()
        count = 0
        for c in word:
            if c.islower() and c.upper() in seen:
                count += 1
            elif c.isupper() and c.lower() in seen:
                count += 1
            seen.add(c)
        return count