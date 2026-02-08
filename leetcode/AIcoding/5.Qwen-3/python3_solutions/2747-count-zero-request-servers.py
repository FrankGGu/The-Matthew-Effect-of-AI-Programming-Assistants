class Solution:
    def countZeroRequests(self, servers: List[int], requests: List[int]) -> int:
        from collections import deque

        queue = deque()
        for req in requests:
            queue.append(req)

        while queue:
            current = queue.popleft()
            if servers[current] == 0:
                return len(queue)
            servers[current] -= 1

        return len(queue)