class Solution:
    def sumOfBeauty(self, nums: List[int]) -> int:
        n = len(nums)
        left_min = [0] * n
        right_max = [0] * n

        left_min[0] = nums[0]
        for i in range(1, n):
            left_min[i] = min(left_min[i - 1], nums[i])

        right_max[n - 1] = nums[n - 1]
        for i in range(n - 2, -1, -1):
            right_max[i] = max(right_max[i + 1], nums[i])

        res = 0
        for i in range(1, n - 1):
            if left_min[i - 1] < nums[i] and nums[i] < right_max[i + 1]:
                res += 1
        return res