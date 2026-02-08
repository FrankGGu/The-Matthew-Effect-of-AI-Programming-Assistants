class Solution:
    def minSpaceWastedNumbers(self, nums: List[int], numBars: int) -> List[int]:
        from bisect import bisect_left

        n = len(nums)
        prefix = [0] * (n + 1)
        for i in range(n):
            prefix[i + 1] = prefix[i] + nums[i]

        def get_min_waste(k):
            dp = [[float('inf')] * (k + 1) for _ in range(n + 1)]
            dp[0][0] = 0
            for i in range(1, n + 1):
                for j in range(1, k + 1):
                    for m in range(i):
                        if dp[m][j - 1] != float('inf'):
                            total = prefix[i] - prefix[m]
                            avg = total / (i - m)
                            waste = sum(abs(x - avg) for x in nums[m:i])
                            dp[i][j] = min(dp[i][j], dp[m][j - 1] + waste)
            return dp[n][k]

        result = []
        for k in range(1, numBars + 1):
            result.append(get_min_waste(k))
        return result