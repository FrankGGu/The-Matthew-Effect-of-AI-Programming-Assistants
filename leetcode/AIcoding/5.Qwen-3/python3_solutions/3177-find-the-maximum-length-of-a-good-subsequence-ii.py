class Solution:
    def maxLength(self, s: str, k: int) -> int:
        from collections import defaultdict

        dp = [defaultdict(int) for _ in range(k + 1)]
        dp[0][0] = 0

        for c in s:
            for i in range(k, 0, -1):
                for key in list(dp[i - 1].keys()):
                    if c == '(':
                        dp[i][key + 1] = max(dp[i][key + 1], dp[i - 1][key] + 1)
                    else:
                        if key > 0:
                            dp[i][key - 1] = max(dp[i][key - 1], dp[i - 1][key] + 1)

        return max(dp[k].values())