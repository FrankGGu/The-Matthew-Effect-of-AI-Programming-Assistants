class Solution:
    def maxProductOfLength(self, s: str) -> int:
        n = len(s)
        pal = [0] * n
        for i in range(n):
            l, r = i, i
            while l >= 0 and r < n and s[l] == s[r]:
                pal[l] = max(pal[l], r - l + 1)
                l -= 1
                r += 1
            l, r = i, i + 1
            while l >= 0 and r < n and s[l] == s[r]:
                pal[l] = max(pal[l], r - l + 1)
                l -= 1
                r += 1
        max_prod = 0
        for i in range(n):
            for j in range(i + 1, n):
                if pal[i] > 0 and pal[j] > 0:
                    max_prod = max(max_prod, pal[i] * pal[j])
        return max_prod