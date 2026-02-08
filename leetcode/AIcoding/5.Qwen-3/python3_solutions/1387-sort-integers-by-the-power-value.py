class Solution:
    def sortTransformedArray(self, nums: List[int], k: int) -> List[int]:
        def power(x: int) -> int:
            return x * x + k * x

        return sorted(nums, key=power)