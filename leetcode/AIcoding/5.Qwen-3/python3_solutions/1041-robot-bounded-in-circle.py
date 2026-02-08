class Solution:
    def isRobotBounded(self, instructions: str) -> bool:
        x, y = 0, 0
        directions = [(0, 1), (1, 0), (0, -1), (-1, 0)]
        dir_idx = 0

        for inst in instructions:
            if inst == 'G':
                x += directions[dir_idx][0]
                y += directions[dir_idx][1]
            elif inst == 'L':
                dir_idx = (dir_idx - 1) % 4
            elif inst == 'R':
                dir_idx = (dir_idx + 1) % 4

        return (x == 0 and y == 0) or dir_idx != 0