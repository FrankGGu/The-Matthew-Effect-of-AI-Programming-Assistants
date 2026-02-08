from typing import List

class Solution:
    def getFinalState(self, nums: List[int], k: int, m: int) -> int:
        for _ in range(k):
            new_nums = []
            for num in nums:
                new_nums.append(num % m)
            nums = new_nums
        return sum(nums)