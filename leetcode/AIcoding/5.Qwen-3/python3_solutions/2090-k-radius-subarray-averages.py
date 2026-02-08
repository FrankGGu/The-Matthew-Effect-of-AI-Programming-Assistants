from typing import List

class Solution:
    def findAverages(self, nums: List[int], k: int) -> List[int]:
        n = len(nums)
        result = []
        window_sum = sum(nums[:k])
        result.append(window_sum / k)

        for i in range(1, n - k + 1):
            window_sum = window_sum - nums[i - 1] + nums[i + k - 1]
            result.append(window_sum / k)

        return result