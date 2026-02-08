class Solution:
    def numRollsToTarget(self, d: int, f: int, target: int) -> int:
        MOD = 10**9 + 7
        dp = [0] * (target + 1)
        dp[0] = 1

        for _ in range(d):
            new_dp = [0] * (target + 1)
            for t in range(target + 1):
                for face in range(1, f + 1):
                    if t - face >= 0:
                        new_dp[t] += dp[t - face]
                        new_dp[t] %= MOD
            dp = new_dp

        return dp[target]