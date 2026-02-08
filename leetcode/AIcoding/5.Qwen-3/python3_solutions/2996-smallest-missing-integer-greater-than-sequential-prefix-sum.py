class Solution:
    def missingInteger(self, nums: List[int]) -> int:
        n = len(nums)
        prefix = [nums[0]]
        for i in range(1, n):
            if nums[i] == prefix[-1] + 1:
                prefix.append(nums[i])
            else:
                break
        target = prefix[-1] + 1
        while True:
            if target not in nums:
                return target
            target += 1