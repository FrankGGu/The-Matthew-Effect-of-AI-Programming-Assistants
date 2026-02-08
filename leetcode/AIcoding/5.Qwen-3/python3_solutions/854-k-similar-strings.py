from collections import deque
import sys

class Solution:
    def kSimilarString(self, s: str, t: str, k: int) -> int:
        def get_neighbors(s):
            s = list(s)
            for i in range(len(s)):
                if s[i] != t[i]:
                    for j in range(i + 1, len(s)):
                        if s[j] == t[i] and s[i] == t[j]:
                            s[i], s[j] = s[j], s[i]
                            yield ''.join(s)
                            s[i], s[j] = s[j], s[i]
            return

        queue = deque([(s, 0)])
        visited = {s}

        while queue:
            current, steps = queue.popleft()
            if current == t:
                return steps
            for neighbor in get_neighbors(current):
                if neighbor not in visited:
                    visited.add(neighbor)
                    queue.append((neighbor, steps + 1))
        return -1