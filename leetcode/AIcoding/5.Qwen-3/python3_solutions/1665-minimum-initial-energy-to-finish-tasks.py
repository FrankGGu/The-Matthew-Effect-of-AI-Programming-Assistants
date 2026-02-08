class Solution:
    def minInitialEnergy(self, tasks):
        total = 0
        max_diff = 0
        for cost, gain in tasks:
            total += cost
            max_diff = max(max_diff, gain - cost)
        return total + max(0, max_diff)