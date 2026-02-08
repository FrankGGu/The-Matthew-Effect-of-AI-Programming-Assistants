class Solution:
    def maxSpaceWastedKResizing(self, nums: List[int], k: int) -> int:
        n = len(nums)
        dp = [[-1] * (k + 1) for _ in range(n)]

        def get_min_max(start, end):
            min_val = float('inf')
            max_val = -float('inf')
            for i in range(start, end + 1):
                min_val = min(min_val, nums[i])
                max_val = max(max_val, nums[i])
            return min_val, max_val

        def dfs(i, ops):
            if i == n:
                return 0
            if dp[i][ops] != -1:
                return dp[i][ops]
            res = 0
            min_val, max_val = get_min_max(i, i)
            res = max_val - min_val
            for j in range(i + 1, n):
                min_val, max_val = get_min_max(i, j)
                if ops < k:
                    res = max(res, dfs(j + 1, ops + 1))
                else:
                    res = max(res, max_val - min_val)
            dp[i][ops] = res
            return res

        return dfs(0, 0)