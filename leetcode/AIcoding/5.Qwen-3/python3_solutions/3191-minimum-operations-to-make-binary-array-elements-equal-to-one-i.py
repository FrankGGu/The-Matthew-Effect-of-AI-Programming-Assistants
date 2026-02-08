class Solution:
    def minOperations(self, nums: List[int]) -> int:
        operations = 0
        flip = 0
        for i in range(len(nums)):
            if nums[i] ^ flip == 1:
                operations += 1
                flip ^= 1
        return operations