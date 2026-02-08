class Solution:
    def largestSumOfAverages(self, nums: List[int], k: int) -> float:
        n = len(nums)
        prefix = [0] * (n + 1)
        for i in range(n):
            prefix[i + 1] = prefix[i] + nums[i]

        dp = [0.0] * (n + 1)
        for i in range(1, n + 1):
            dp[i] = (prefix[i] - prefix[0]) / i

        for layer in range(2, k + 1):
            new_dp = [0.0] * (n + 1)
            for i in range(1, n + 1):
                for j in range(i):
                    new_dp[i] = max(new_dp[i], dp[j] + (prefix[i] - prefix[j]) / (i - j))
            dp = new_dp

        return dp[n]