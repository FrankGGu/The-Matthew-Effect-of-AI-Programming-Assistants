class Solution:
    def maxPower(self, s: str) -> int:
        max_count = 1
        current_count = 1
        for i in range(1, len(s)):
            if s[i] == s[i - 1]:
                current_count += 1
                if current_count > max_count:
                    max_count = current_count
            else:
                current_count = 1
        return max_count