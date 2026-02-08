class Solution:
    def minFinishTime(self, tires: List[List[int]], laps: int) -> int:
        from collections import deque

        max_time = 1000000
        min_time = [max_time] * (laps + 1)
        min_time[0] = 0

        for lap in range(1, laps + 1):
            for a, b in tires:
                time = 0
                for i in range(1, 17):
                    if i > lap:
                        break
                    time += b
                    if time >= max_time:
                        break
                    min_time[lap] = min(min_time[lap], min_time[lap - i] + time)

        return min_time[laps]