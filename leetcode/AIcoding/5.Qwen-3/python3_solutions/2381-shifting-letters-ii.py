class Solution:
    def shiftingLetters(self, s: str, shifts: List[int]) -> str:
        n = len(s)
        for i in range(n - 1, -1, -1):
            shifts[i] += shifts[i + 1] if i + 1 < n else 0
            shifts[i] %= 26
        return ''.join(chr((ord(c) - ord('a') + shifts[i]) % 26 + ord('a')) for i, c in enumerate(s))