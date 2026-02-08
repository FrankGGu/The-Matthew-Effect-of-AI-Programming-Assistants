class Solution:
    def maxOperations(self, nums: List[int]) -> int:
        from collections import defaultdict

        n = len(nums)
        dp = [defaultdict(int) for _ in range(n)]
        max_ops = 0

        for i in range(n):
            for j in range(i):
                diff = nums[i] - nums[j]
                if diff in dp[j]:
                    dp[i][diff] = dp[j][diff] + 1
                else:
                    dp[i][diff] = 1
                max_ops = max(max_ops, dp[i][diff])

        return max_ops