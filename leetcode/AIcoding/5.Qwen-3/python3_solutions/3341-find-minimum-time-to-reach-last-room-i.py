class Solution:
    def minTimeToReach(self, position: int) -> int:
        from collections import deque

        visited = set()
        queue = deque([(0, 0)])  # (time, room)
        visited.add(0)

        while queue:
            time, room = queue.popleft()
            if room == position:
                return time
            next_room1 = room + 1
            next_room2 = room * 2
            for next_room in [next_room1, next_room2]:
                if next_room not in visited:
                    visited.add(next_room)
                    queue.append((time + 1, next_room))
        return -1