class Solution:
    def maxSumDivThree(self, nums: List[int]) -> int:
        dp = [0]
        for num in nums:
            temp = dp.copy()
            for val in temp:
                if (val + num) % 3 == 0:
                    dp.append(val + num)
        return max(dp)