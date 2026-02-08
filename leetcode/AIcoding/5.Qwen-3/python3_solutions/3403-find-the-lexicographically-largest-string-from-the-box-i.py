class Solution:
    def removeBoxes(self, boxes: str) -> str:
        n = len(boxes)
        dp = [[0] * n for _ in range(n)]

        for i in range(n):
            dp[i][i] = 1

        for length in range(2, n + 1):
            for i in range(n - length + 1):
                j = i + length - 1
                dp[i][j] = 0
                if boxes[i] == boxes[j]:
                    dp[i][j] = 2
                    if i + 1 <= j - 1:
                        dp[i][j] += dp[i + 1][j - 1]
                else:
                    dp[i][j] = max(dp[i][k] + dp[k + 1][j] for k in range(i, j))

        result = []
        i, j = 0, n - 1
        while i <= j:
            if boxes[i] == boxes[j]:
                result.append(boxes[i])
                i += 1
                j -= 1
            else:
                if dp[i][j] == dp[i][j - 1]:
                    j -= 1
                else:
                    i += 1

        return ''.join(result)