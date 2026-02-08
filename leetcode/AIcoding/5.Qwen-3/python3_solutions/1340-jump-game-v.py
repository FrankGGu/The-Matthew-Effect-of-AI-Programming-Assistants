class Solution:
    def maxJumps(self, arr: list[int], time: int) -> int:
        n = len(arr)
        dp = [0] * n
        stack = []
        for i in range(n):
            while stack and arr[stack[-1]] < arr[i]:
                j = stack.pop()
                dp[i] = max(dp[i], dp[j] + time)
            stack.append(i)
        return max(dp)