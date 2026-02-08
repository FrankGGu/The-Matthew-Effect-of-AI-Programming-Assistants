class Solution:
    def minChanges(self, s: str, n: int) -> int:
        count = 0
        for i in range(0, len(s), n):
            sub = s[i:i+n]
            half = n // 2
            left = sub[:half]
            right = sub[half:]
            if left != right:
                count += 1
        return count