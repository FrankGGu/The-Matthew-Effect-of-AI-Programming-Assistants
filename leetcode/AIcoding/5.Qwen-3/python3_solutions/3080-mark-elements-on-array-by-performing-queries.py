class Solution:
    def markElements(self, nums: List[int]) -> List[int]:
        n = len(nums)
        res = [0] * n
        seen = set()
        for i in range(n):
            if nums[i] not in seen:
                seen.add(nums[i])
                res[i] = 1
        return res