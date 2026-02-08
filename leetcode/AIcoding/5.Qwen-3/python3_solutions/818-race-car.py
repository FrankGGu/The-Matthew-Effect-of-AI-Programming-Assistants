class Solution:
    def racecar(self, target: int) -> int:
        from collections import deque

        queue = deque([(0, 0, 1)])  # (position, steps, speed)
        visited = set((0, 1))

        while queue:
            pos, steps, speed = queue.popleft()
            if pos == target:
                return steps
            # Accelerate
            new_pos = pos + speed
            new_speed = speed * 2
            if (new_pos, new_speed) not in visited and 0 <= new_pos <= 2 * target:
                visited.add((new_pos, new_speed))
                queue.append((new_pos, steps + 1, new_speed))
            # Reverse
            new_speed_rev = -1 if speed > 0 else 1
            if (pos, new_speed_rev) not in visited:
                visited.add((pos, new_speed_rev))
                queue.append((pos, steps + 1, new_speed_rev))