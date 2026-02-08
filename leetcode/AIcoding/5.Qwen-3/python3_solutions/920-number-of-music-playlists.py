class Solution:
    def numMusicPlaylists(self, n: int, k: int, l: int) -> int:
        MOD = 10**9 + 7
        dp = [0] * (l + 1)
        dp[0] = 1
        for i in range(1, l + 1):
            dp[i] = (dp[i - 1] * (n - (i - 1))) % MOD
            if i > k:
                dp[i] = (dp[i] - dp[i - k - 1] * (n - (i - k - 1))) % MOD
        return dp[l]