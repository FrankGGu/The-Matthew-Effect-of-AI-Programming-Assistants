class Solution:
    def maximumScore(self, intervals: List[List[int]]) -> int:
        intervals.sort(key=lambda x: x[1])
        n = len(intervals)
        dp = [0] * n
        for i in range(n):
            current = intervals[i][2]
            left, right = 0, i - 1
            while left <= right:
                mid = (left + right) // 2
                if intervals[mid][1] <= intervals[i][0]:
                    left = mid + 1
                else:
                    right = mid - 1
            if left > 0:
                current += dp[left - 1]
            dp[i] = max(dp[i - 1], current)
        return dp[-1]