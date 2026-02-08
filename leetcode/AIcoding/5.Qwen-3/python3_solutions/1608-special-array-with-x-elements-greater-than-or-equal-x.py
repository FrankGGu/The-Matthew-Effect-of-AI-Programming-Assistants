class Solution:
    def specialArray(self, nums: List[int]) -> int:
        nums.sort()
        n = len(nums)
        for i in range(1, n + 1):
            if nums[n - i] >= i and (n - i == 0 or nums[n - i - 1] < i):
                return i
        return -1