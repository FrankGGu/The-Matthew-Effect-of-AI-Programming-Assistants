class Solution:
    def maximumTripletValue(self, nums: List[int]) -> int:
        n = len(nums)
        max_val = 0
        for i in range(n):
            for j in range(i + 1, n):
                if nums[i] > nums[j]:
                    for k in range(j + 1, n):
                        if nums[j] > nums[k]:
                            max_val = max(max_val, nums[i] - nums[j] + nums[k])
        return max_val