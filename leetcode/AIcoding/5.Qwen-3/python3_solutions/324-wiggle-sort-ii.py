class Solution:
    def wiggleSort(self, nums: List[int]) -> None:
        nums.sort()
        mid = (len(nums) + 1) // 2
        left = nums[:mid]
        right = nums[mid:]
        nums.clear()
        for i in range(len(right)):
            nums.append(left[i])
            nums.append(right[i])
        if len(left) > len(right):
            nums.append(left[-1])