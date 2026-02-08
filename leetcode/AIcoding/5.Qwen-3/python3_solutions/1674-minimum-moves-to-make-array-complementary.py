class Solution:
    def minMoves(self, nums: List[int], limit: int) -> int:
        n = len(nums)
        diff = [0] * (2 * limit + 2)

        for i in range(n // 2):
            a = nums[i]
            b = nums[n - 1 - i]
            min_val = min(a, b)
            max_val = max(a, b)
            target = a + b

            diff[min_val + 1] += 1
            diff[max_val + 1] -= 1
            diff[1] += 1
            diff[target] -= 1

        res = 0
        current = 0
        for i in range(2 * limit + 1):
            current += diff[i]
            res = min(res, current)

        return res