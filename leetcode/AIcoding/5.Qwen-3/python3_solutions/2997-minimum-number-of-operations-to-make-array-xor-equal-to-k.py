class Solution:
    def minOperations(self, nums: List[int], k: int) -> int:
        xor = 0
        for num in nums:
            xor ^= num
        ops = 0
        while xor != k:
            xor ^= 1
            ops += 1
        return ops