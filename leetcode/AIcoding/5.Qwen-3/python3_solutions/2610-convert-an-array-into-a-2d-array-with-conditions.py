class Solution:
    def find2DArray(self, nums: List[int], k: int, n: int) -> List[List[int]]:
        result = []
        for i in range(n):
            result.append(nums[i * k:(i + 1) * k])
        return result