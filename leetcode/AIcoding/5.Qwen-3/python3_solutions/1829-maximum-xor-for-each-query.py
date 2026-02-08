class Solution:
    def getMaximumXor(self, nums: List[int], maximumBit: int) -> List[int]:
        max_xor = 0
        result = []
        for num in nums:
            max_xor ^= num
            result.append(max_xor)
        return result[::-1]