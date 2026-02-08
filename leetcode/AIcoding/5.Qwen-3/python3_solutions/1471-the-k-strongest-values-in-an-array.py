class Solution:
    def getStrongest(self, nums: List[int], k: int) -> List[int]:
        nums.sort()
        median = nums[(len(nums) - 1) // 2]
        nums.sort(key=lambda x: (-abs(x - median), -x))
        return nums[:k]