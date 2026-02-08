class Solution:
    def numSubstrings(self, s: str) -> int:
        count = 0
        n = len(s)
        for i in range(n):
            if s[i] == '1':
                j = i
                while j < n and s[j] == '1':
                    count += 1
                    j += 1
        return count