class Solution:
    def minCostToMakeArray(self, nums: List[int], cost: List[int]) -> int:
        from collections import defaultdict

        pos = defaultdict(list)
        for i, num in enumerate(nums):
            pos[num].append(cost[i])

        total_cost = 0
        for key in pos:
            pos[key].sort()

        median = None
        count = 0
        for key in sorted(pos.keys()):
            if count + len(pos[key]) >= len(nums) // 2:
                median = key
                break
            count += len(pos[key])

        for i, num in enumerate(nums):
            total_cost += abs(num - median) * cost[i]

        return total_cost