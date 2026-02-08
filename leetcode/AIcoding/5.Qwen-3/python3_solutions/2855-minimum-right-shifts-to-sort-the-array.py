class Solution:
    def minimumRightShifts(self, nums: List[int]) -> int:
        n = len(nums)
        for i in range(n):
            if nums[i] > nums[(i + 1) % n]:
                return (n - i - 1) % n
        return 0