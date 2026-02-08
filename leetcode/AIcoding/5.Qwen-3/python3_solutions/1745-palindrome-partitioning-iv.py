class Solution:
    def checkPartitioning(self, s: str) -> bool:
        n = len(s)
        is_pal = [[False] * n for _ in range(n)]

        for i in range(n - 1, -1, -1):
            for j in range(i, n):
                if i == j:
                    is_pal[i][j] = True
                elif s[i] == s[j]:
                    if j - i == 1:
                        is_pal[i][j] = True
                    else:
                        is_pal[i][j] = is_pal[i + 1][j - 1]

        for i in range(1, n - 1):
            if is_pal[0][i]:
                for j in range(i + 1, n - 1):
                    if is_pal[i + 1][j] and is_pal[j + 1][n - 1]:
                        return True
        return False