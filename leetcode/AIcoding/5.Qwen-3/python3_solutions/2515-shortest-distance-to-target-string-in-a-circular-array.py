class Solution:
    def closetTarget(self, nums: List[int], target: int, start: int) -> int:
        n = len(nums)
        min_dist = float('inf')
        for i in range(n):
            if nums[i] == target:
                dist = min(abs(i - start), n - abs(i - start))
                min_dist = min(min_dist, dist)
        return min_dist