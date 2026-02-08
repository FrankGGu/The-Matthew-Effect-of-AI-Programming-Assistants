class Solution:
    def distinctAverages(self, nums: List[int]) -> int:
        nums.sort()
        seen = set()
        n = len(nums)
        for i in range(n // 2):
            avg = (nums[i] + nums[n - 1 - i]) / 2
            seen.add(avg)
        return len(seen)