class Solution:
    def countSubstrings(self, s: str) -> int:
        count = 0
        for i in range(len(s)):
            for j in range(i + 1, len(s) + 1):
                substr = s[i:j]
                last_digit = int(substr[-1])
                if last_digit != 0 and int(substr) % last_digit == 0:
                    count += 1
        return count