class Solution:
    def canCross(self, stones) -> bool:
        if not stones:
            return False
        if stones[0] != 0:
            return False
        from collections import defaultdict, deque

        jump_map = defaultdict(set)
        for i, stone in enumerate(stones):
            jump_map[stone].add(i)

        queue = deque()
        queue.append((0, 0))
        visited = set()
        visited.add((0, 0))

        while queue:
            position, step = queue.popleft()
            if position == stones[-1]:
                return True
            for next_step in [step - 1, step, step + 1]:
                if next_step > 0:
                    next_position = position + next_step
                    if next_position in jump_map:
                        for i in jump_map[next_position]:
                            if (next_position, next_step) not in visited:
                                visited.add((next_position, next_step))
                                queue.append((next_position, next_step))
        return False