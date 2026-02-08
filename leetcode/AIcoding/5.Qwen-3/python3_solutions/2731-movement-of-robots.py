class Solution:
    def robotSim(self, n: int, startPos: List[int], homePos: List[int], obstacles: List[List[int]]) -> int:
        import math
        from collections import defaultdict

        directions = [(0, 1), (1, 0), (0, -1), (-1, 0)]
        dir_idx = 0
        x, y = startPos
        max_distance = 0
        obstacle_set = set((x, y) for x, y in obstacles)

        while True:
            dx, dy = directions[dir_idx]
            next_x, next_y = x + dx, y + dy
            if (next_x, next_y) in obstacle_set:
                dir_idx = (dir_idx + 1) % 4
                continue
            if abs(next_x - homePos[0]) + abs(next_y - homePos[1]) < abs(x - homePos[0]) + abs(y - homePos[1]):
                max_distance = max(max_distance, math.hypot(next_x - startPos[0], next_y - startPos[1]))
            x, y = next_x, next_y
            if (x, y) == (homePos[0], homePos[1]):
                break
        return int(max_distance)