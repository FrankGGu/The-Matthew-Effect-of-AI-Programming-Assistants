from typing import List

class Solution:
    def optimalDivision(self, nums: List[int]) -> str:
        if len(nums) == 1:
            return str(nums[0])
        if len(nums) == 2:
            return f"{nums[0]}/{nums[1]}"
        res = f"{nums[0]}/"
        for i in range(1, len(nums)):
            res += f"{nums[i]}"
            if i != len(nums) - 1:
                res += "/"
        return res