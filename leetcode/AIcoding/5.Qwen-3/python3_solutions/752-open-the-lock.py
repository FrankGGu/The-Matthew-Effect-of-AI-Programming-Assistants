from collections import deque

class Solution:
    def openLock(self, deadends: List[str], target: str) -> int:
        dead = set(deadends)
        visited = set()
        queue = deque()
        queue.append(("0000", 0))
        visited.add("0000")

        while queue:
            current, steps = queue.popleft()
            if current == target:
                return steps
            if current in dead:
                continue
            for i in range(4):
                for delta in (-1, 1):
                    next_digit = (int(current[i]) + delta) % 10
                    next_state = current[:i] + str(next_digit) + current[i+1:]
                    if next_state not in visited and next_state not in dead:
                        visited.add(next_state)
                        queue.append((next_state, steps + 1))
        return -1