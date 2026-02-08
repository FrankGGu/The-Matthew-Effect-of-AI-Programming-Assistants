class Solution:
    def minCost(self, nums: List[int], cost: List[int]) -> int:
        pairs = sorted(zip(nums, cost))
        total_cost = 0
        median = None
        for num, c in pairs:
            total_cost += c
        mid = total_cost // 2
        current = 0
        for num, c in pairs:
            current += c
            if current > mid:
                median = num
                break
        return sum(abs(num - median) * c for num, c in pairs)