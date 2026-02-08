class Solution:
    def maxPoints(self, points: List[List[int]]) -> int:
        from collections import defaultdict

        rows = len(points)
        cols = len(points[0])

        dp = [0] * cols
        for i in range(rows):
            new_dp = [0] * cols
            left = [0] * cols
            right = [0] * cols

            left[0] = dp[0]
            for j in range(1, cols):
                left[j] = max(left[j - 1] - 1, dp[j])

            right[cols - 1] = dp[cols - 1]
            for j in range(cols - 2, -1, -1):
                right[j] = max(right[j + 1] - 1, dp[j])

            for j in range(cols):
                new_dp[j] = points[i][j] + max(left[j], right[j])
            dp = new_dp

        return max(dp)