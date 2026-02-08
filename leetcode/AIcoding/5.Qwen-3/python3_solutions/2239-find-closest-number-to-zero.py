class Solution:
    def closestToZero(self, nums: List[int]) -> int:
        closest = nums[0]
        for num in nums[1:]:
            if abs(num) < abs(closest):
                closest = num
            elif abs(num) == abs(closest):
                if num > closest:
                    closest = num
        return closest