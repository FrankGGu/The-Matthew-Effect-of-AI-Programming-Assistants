class Solution:
    def maxDistanceToClosest(self, nums: List[int]) -> int:
        n = len(nums)
        left = [0] * n
        right = [0] * n

        for i in range(n):
            if nums[i] == 1:
                left[i] = 0
            else:
                if i == 0:
                    left[i] = float('inf')
                else:
                    left[i] = left[i - 1] + 1

        for i in range(n - 1, -1, -1):
            if nums[i] == 1:
                right[i] = 0
            else:
                if i == n - 1:
                    right[i] = float('inf')
                else:
                    right[i] = right[i + 1] + 1

        max_dist = 0
        for i in range(n):
            max_dist = max(max_dist, min(left[i], right[i]))

        return max_dist