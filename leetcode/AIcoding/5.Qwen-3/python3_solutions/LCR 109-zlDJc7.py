from collections import deque

class Solution:
    def openLock(self, deadends: list[str], target: str) -> int:
        dead = set(deadends)
        visited = set()
        queue = deque()
        queue.append(("0000", 0))
        visited.add("0000")

        while queue:
            node, steps = queue.popleft()
            if node == target:
                return steps
            if node in dead:
                continue
            for i in range(4):
                for delta in (-1, 1):
                    next_node = node[:i] + str((int(node[i]) + delta) % 10) + node[i+1:]
                    if next_node not in visited:
                        visited.add(next_node)
                        queue.append((next_node, steps + 1))

        return -1