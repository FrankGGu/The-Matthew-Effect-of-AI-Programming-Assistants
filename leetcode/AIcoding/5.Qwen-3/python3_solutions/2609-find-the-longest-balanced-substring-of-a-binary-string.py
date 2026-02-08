class Solution:
    def longestBalancedSubstring(self, s: str) -> int:
        max_len = 0
        n = len(s)
        for i in range(n):
            zeros = 0
            ones = 0
            for j in range(i, n):
                if s[j] == '0':
                    zeros += 1
                else:
                    ones += 1
                if zeros == ones:
                    max_len = max(max_len, zeros + ones)
        return max_len