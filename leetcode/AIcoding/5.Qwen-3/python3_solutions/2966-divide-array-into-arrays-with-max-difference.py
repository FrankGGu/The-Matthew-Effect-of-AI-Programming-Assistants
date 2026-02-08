class Solution:
    def divideArray(self, nums: List[int], k: int) -> bool:
        nums.sort()
        for i in range(0, len(nums), 3):
            if i + 2 >= len(nums) or nums[i + 2] - nums[i] > k:
                return False
        return True