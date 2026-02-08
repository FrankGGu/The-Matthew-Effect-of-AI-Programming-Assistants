class Solution:
    def robotSim(self, instructions: str, m: int, n: int) -> int:
        directions = [(0, 1), (1, 0), (0, -1), (-1, 0)]
        x, y = 0, 0
        dx, dy = 0, 1
        max_distance = 0
        obstacles = set()
        for i in range(len(instructions)):
            if instructions[i] == 'L':
                dx, dy = directions[(directions.index((dx, dy)) - 1) % 4]
            elif instructions[i] == 'R':
                dx, dy = directions[(directions.index((dx, dy)) + 1) % 4]
            else:
                nx, ny = x + dx, y + dy
                if 0 <= nx < m and 0 <= ny < n:
                    x, y = nx, ny
                max_distance = max(max_distance, x * x + y * y)
        return max_distance