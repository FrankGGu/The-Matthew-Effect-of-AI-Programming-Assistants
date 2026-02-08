class Solution:
    def minOperations(self, nums: List[int]) -> int:
        from collections import defaultdict

        n = len(nums)
        dp = [0] * n
        count = defaultdict(int)

        for i in range(n):
            for j in range(i):
                if nums[i] % nums[j] == 0:
                    dp[i] = max(dp[i], dp[j] + 1)
            count[nums[i]] += 1

        return n - max(dp) - 1