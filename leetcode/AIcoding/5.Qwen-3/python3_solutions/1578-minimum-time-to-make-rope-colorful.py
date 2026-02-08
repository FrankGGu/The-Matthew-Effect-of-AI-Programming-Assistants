class Solution:
    def minCost(self, colors: str, neededTime: list[int]) -> int:
        total_time = 0
        max_time = 0
        for i in range(len(colors)):
            if i > 0 and colors[i] == colors[i - 1]:
                total_time += neededTime[i]
                max_time = max(max_time, neededTime[i])
            else:
                total_time -= max_time
                max_time = neededTime[i]
        return total_time