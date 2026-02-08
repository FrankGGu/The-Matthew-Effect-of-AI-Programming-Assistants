class Solution:
    def countSubMultisets(self, nums: List[int], sumLimit: int) -> int:
        from collections import Counter

        MOD = 10**9 + 7
        cnt = Counter(nums)
        dp = [1] * (sumLimit + 1)
        for num, freq in cnt.items():
            if num == 0:
                continue
            for s in range(sumLimit, num - 1, -1):
                for k in range(1, freq + 1):
                    if s - k * num >= 0:
                        dp[s] = (dp[s] + dp[s - k * num]) % MOD
                    else:
                        break
        return dp[sumLimit]