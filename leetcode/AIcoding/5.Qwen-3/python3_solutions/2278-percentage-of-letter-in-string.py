class Solution:
    def percentageLetter(self, s: str, letter: str) -> int:
        count = s.count(letter)
        total = len(s)
        return (count * 100) // total