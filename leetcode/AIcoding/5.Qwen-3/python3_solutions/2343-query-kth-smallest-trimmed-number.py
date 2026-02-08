class Solution:
    def closestNumbers(self, nums: List[int], k: int, x: int) -> List[int]:
        def key_func(num):
            return abs(num - x)

        nums.sort(key=key_func)
        return nums[:k]