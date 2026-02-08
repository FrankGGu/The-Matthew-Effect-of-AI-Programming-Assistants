class Solution:
    def slidingPuzzle(self, board: List[List[int]]) -> int:
        from collections import deque

        target = "123456780"
        start = "".join(str(num) for row in board for num in row)

        neighbors = [
            [1, 3],
            [0, 2, 4],
            [1, 5],
            [0, 4, 6],
            [1, 3, 5, 7],
            [2, 4, 8],
            [3, 7],
            [6, 8],
            [5, 7]
        ]

        queue = deque([(start, 0)])
        visited = set([start])

        while queue:
            state, steps = queue.popleft()
            if state == target:
                return steps
            idx = state.index('0')
            for neighbor in neighbors[idx]:
                new_state = list(state)
                new_state[idx], new_state[neighbor] = new_state[neighbor], new_state[idx]
                new_state_str = "".join(new_state)
                if new_state_str not in visited:
                    visited.add(new_state_str)
                    queue.append((new_state_str, steps + 1))

        return -1