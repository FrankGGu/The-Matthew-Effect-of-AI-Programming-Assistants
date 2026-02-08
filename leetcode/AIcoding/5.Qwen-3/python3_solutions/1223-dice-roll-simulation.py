class Solution:
    def dieSimulator(self, n: int, k: int) -> int:
        MOD = 10**9 + 7
        dp = [0] * k
        for i in range(n):
            new_dp = [0] * k
            for j in range(k):
                for m in range(k):
                    if m != j:
                        new_dp[m] = (new_dp[m] + dp[j]) % MOD
            dp = new_dp
        return sum(dp) % MOD