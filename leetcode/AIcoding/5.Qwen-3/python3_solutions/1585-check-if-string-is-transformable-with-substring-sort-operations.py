class Solution:
    def isTransformable(self, s: str, t: str) -> bool:
        from collections import deque

        pos = [deque() for _ in range(10)]
        for i, c in enumerate(s):
            pos[int(c)].append(i)

        for i, c in enumerate(t):
            if not pos[int(c)]:
                return False
            idx = pos[int(c)].popleft()
            for j in range(int(c)):
                if pos[j] and pos[j][0] < idx:
                    return False
        return True