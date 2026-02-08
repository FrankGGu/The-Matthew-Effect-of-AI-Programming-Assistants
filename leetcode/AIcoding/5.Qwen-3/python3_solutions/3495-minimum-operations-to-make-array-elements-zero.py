class Solution:
    def minOperations(self, nums: List[int]) -> int:
        ops = 0
        for num in nums:
            while num > 0:
                if num % 2 == 1:
                    num -= 1
                    ops += 1
                else:
                    num //= 2
                    ops += 1
        return ops