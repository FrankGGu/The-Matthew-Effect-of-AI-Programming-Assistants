class Solution:
    def findRelativeRanks(self, nums):
        sorted_nums = sorted(nums, reverse=True)
        rank_map = {}
        for i, num in enumerate(sorted_nums):
            if i == 0:
                rank_map[num] = "Gold Medal"
            elif i == 1:
                rank_map[num] = "Silver Medal"
            elif i == 2:
                rank_map[num] = "Bronze Medal"
            else:
                rank_map[num] = str(i + 1)
        return [rank_map[num] for num in nums]