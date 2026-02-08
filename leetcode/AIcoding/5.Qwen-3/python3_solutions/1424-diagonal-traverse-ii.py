class Solution:
    def findDiagonalOrder(self, nums: List[List[int]]) -> List[int]:
        from collections import defaultdict
        diag = defaultdict(list)
        for i in range(len(nums)):
            for j in range(len(nums[i])):
                diag[i + j].append(nums[i][j])
        result = []
        for key in sorted(diag.keys()):
            result.extend(diag[key][::-1])
        return result