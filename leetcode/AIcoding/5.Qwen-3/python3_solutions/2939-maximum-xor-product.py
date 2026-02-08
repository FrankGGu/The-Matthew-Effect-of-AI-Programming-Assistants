class Solution:
    def maximumXorProduct(self, a: int, b: int, nums: List[int]) -> int:
        MOD = 10**9 + 7
        nums.sort(reverse=True)
        for num in nums:
            if (a ^ num) > (a ^ b):
                a, b = max(a, b), min(a, b)
                a ^= num
            elif (b ^ num) > (a ^ b):
                a, b = max(a, b), min(a, b)
                b ^= num
        return (a * b) % MOD