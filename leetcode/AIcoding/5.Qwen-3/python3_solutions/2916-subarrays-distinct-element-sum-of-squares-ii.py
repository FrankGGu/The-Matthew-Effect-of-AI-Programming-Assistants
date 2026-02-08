class Solution:
    def sumOfSquareDigits(self, sub: list[int]) -> int:
        count = {}
        for num in sub:
            count[num] = count.get(num, 0) + 1
        res = 0
        for v in count.values():
            res += v * v
        return res

    def sumCounts(self, nums: list[int]) -> int:
        n = len(nums)
        total = 0
        for i in range(n):
            seen = {}
            for j in range(i, n):
                seen[nums[j]] = seen.get(nums[j], 0) + 1
                total += len(seen) * len(seen)
        return total