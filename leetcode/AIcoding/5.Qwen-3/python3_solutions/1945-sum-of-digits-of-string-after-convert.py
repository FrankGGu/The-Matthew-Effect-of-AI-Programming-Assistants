class Solution:
    def getLucky(self, s: str, k: int) -> int:
        digits = []
        for char in s:
            num = ord(char) - ord('a') + 1
            digits.extend(list(str(num)))
        for _ in range(k):
            total = 0
            for d in digits:
                total += int(d)
            digits = list(str(total))
        return int(''.join(digits))