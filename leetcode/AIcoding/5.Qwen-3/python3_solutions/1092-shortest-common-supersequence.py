class Solution:
    def shortestCommonSupersequence(self, s1: str, s2: str) -> str:
        def lcs(a, b):
            m, n = len(a), len(b)
            dp = [["" for _ in range(n+1)] for _ in range(m+1)]
            for i in range(m):
                for j in range(n):
                    if a[i] == b[j]:
                        dp[i+1][j+1] = dp[i][j] + a[i]
                    else:
                        dp[i+1][j+1] = max(dp[i+1][j], dp[i][j+1], key=len)
            return dp[m][n]

        common = lcs(s1, s2)
        i = j = k = 0
        result = []
        while k < len(common):
            while i < len(s1) and s1[i] != common[k]:
                result.append(s1[i])
                i += 1
            while j < len(s2) and s2[j] != common[k]:
                result.append(s2[j])
                j += 1
            result.append(common[k])
            i += 1
            j += 1
            k += 1
        while i < len(s1):
            result.append(s1[i])
            i += 1
        while j < len(s2):
            result.append(s2[j])
            j += 1
        return ''.join(result)