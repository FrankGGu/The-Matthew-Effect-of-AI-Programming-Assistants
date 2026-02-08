class Solution:
    def maxEnergyBoost(self, energyDrinkA, energyDrinkB):
        n = len(energyDrinkA)
        dp = [0] * n
        dp[0] = energyDrinkA[0]
        for i in range(1, n):
            dp[i] = max(dp[i - 1] + energyDrinkA[i], dp[i - 1] + energyDrinkB[i])
        return dp[-1]