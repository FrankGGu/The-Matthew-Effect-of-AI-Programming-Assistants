class Solution:
    def mostPoints(self, questions: List[List[int]]) -> int:
        n = len(questions)
        dp = [0] * n

        for i in range(n - 1, -1, -1):
            points, brainpower = questions[i]
            if i + brainpower + 1 < n:
                dp[i] = max(points + dp[i + brainpower + 1], dp[i + 1])
            else:
                dp[i] = max(points, dp[i + 1] if i + 1 < n else 0)

        return dp[0]