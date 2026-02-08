class Solution:
    def tupleSameProduct(self, nums: List[int]) -> int:
        from collections import defaultdict

        count = defaultdict(int)
        n = len(nums)
        for i in range(n):
            for j in range(i + 1, n):
                product = nums[i] * nums[j]
                count[product] += 1

        result = 0
        for c in count.values():
            if c >= 2:
                result += c * (c - 1) // 2

        return result