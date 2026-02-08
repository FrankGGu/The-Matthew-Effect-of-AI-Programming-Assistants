class Solution:
    def maximumXOR(self, nums: List[int], queries: List[List[int]]) -> List[int]:
        max_xor = 0
        for num in nums:
            max_xor |= num
        result = []
        for x, m in queries:
            result.append(max_xor & ((1 << m) - 1))
        return result