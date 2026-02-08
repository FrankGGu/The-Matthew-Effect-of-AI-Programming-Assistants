class Solution:
    def temperatureTrend(self, temperatureA: List[int], temperatureB: List[int]) -> int:
        count = 0
        for i in range(1, len(temperatureA)):
            if (temperatureA[i] > temperatureA[i-1] and temperatureB[i] > temperatureB[i-1]) or (temperatureA[i] < temperatureA[i-1] and temperatureB[i] < temperatureB[i-1]):
                count += 1
        return count