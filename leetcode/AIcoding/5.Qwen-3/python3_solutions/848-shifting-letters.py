class Solution:
    def shiftingLetters(self, s: str, shifts: List[int]) -> str:
        n = len(s)
        total_shift = 0
        result = []
        for i in range(n - 1, -1, -1):
            total_shift += shifts[i]
            shifted_char = chr((ord(s[i]) - ord('a') + total_shift) % 26 + ord('a'))
            result.append(shifted_char)
        return ''.join(reversed(result))