class Solution:
    def earliestSecond(self, s: str, target: str) -> int:
        from collections import deque

        n = len(s)
        m = len(target)
        if m > n:
            return -1

        queue = deque()
        for i in range(n):
            if s[i] == target[0]:
                queue.append((i, 0))

        while queue:
            idx, pos = queue.popleft()
            if pos == m - 1:
                return idx
            for i in range(idx + 1, n):
                if s[i] == target[pos + 1]:
                    queue.append((i, pos + 1))
        return -1