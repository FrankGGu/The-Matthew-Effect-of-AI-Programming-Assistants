class Solution:
    def longestSpecialPath(self, x: int, y: int) -> int:
        from collections import deque

        def bfs(start):
            visited = set()
            queue = deque([(start, 0)])
            visited.add(start)
            max_length = 0

            while queue:
                node, length = queue.popleft()
                max_length = max(max_length, length)

                next_node = (node * 10 + x) % y
                if next_node not in visited:
                    visited.add(next_node)
                    queue.append((next_node, length + 1))

                next_node = (node * 10 + y) % x
                if next_node not in visited:
                    visited.add(next_node)
                    queue.append((next_node, length + 1))

            return max_length

        return bfs(0)