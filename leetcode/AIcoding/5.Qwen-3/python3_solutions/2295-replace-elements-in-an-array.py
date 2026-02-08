class Solution:
    def arrayReplaceOperation(self, nums: List[int], operations: List[List[int]]) -> List[int]:
        num_map = {}
        for i in range(len(nums)):
            num_map[nums[i]] = i
        for old, new in operations:
            index = num_map[old]
            nums[index] = new
            num_map[new] = index
        return nums