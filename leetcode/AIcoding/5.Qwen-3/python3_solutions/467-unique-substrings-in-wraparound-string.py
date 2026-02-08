class Solution:
    def findSubstringInWrapup(self, p: str) -> int:
        from collections import defaultdict

        dp = defaultdict(int)
        max_len = 0

        for i in range(len(p)):
            if i > 0 and ord(p[i]) - ord(p[i-1]) == 1:
                max_len += 1
            else:
                max_len = 1
            dp[p[i]] = max(dp[p[i]], max_len)

        return sum(dp.values())