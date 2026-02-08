from collections import deque

class Solution:
    def numberOfOperationsToMakeNumberZero(self, num: int, end: int, k: int) -> int:
        if num == end:
            return 0
        visited = set()
        queue = deque([(num, 0)])
        while queue:
            current, steps = queue.popleft()
            if current in visited:
                continue
            visited.add(current)
            if current % k == 0:
                next_num = current // k
                if next_num == end:
                    return steps + 1
                if next_num not in visited:
                    queue.append((next_num, steps + 1))
            next_num = current - 1
            if next_num == end:
                return steps + 1
            if next_num not in visited:
                queue.append((next_num, steps + 1))
        return -1