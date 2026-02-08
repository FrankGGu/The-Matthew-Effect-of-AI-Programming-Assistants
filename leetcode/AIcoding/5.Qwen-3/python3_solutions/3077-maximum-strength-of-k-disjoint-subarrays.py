class Solution:
    def maxSumDivThree(self, nums: List[int]) -> int:
        from typing import List

        dp = [float('-inf')] * 3
        dp[0] = 0

        for num in nums:
            mod = num % 3
            temp = dp[:]
            for i in range(3):
                if dp[i] != float('-inf'):
                    new_mod = (i + mod) % 3
                    temp[new_mod] = max(temp[new_mod], dp[i] + num)
            dp = temp

        return dp[0]