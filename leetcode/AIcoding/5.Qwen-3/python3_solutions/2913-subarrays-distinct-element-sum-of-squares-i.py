class Solution:
    def sumOfSquareDigits(self, nums: List[int]) -> int:
        from collections import defaultdict

        def get_square_sum(sub):
            count = defaultdict(int)
            for num in sub:
                count[num] += 1
            res = 0
            for k in count:
                res += (count[k] ** 2)
            return res

        n = len(nums)
        total = 0
        for i in range(n):
            for j in range(i + 1, n + 1):
                sub = nums[i:j]
                total += get_square_sum(sub)
        return total