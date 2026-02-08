class Solution:
    def spiralMatrix(self, m: int, n: int, head: Optional[ListNode]) -> List[List[int]]:
        result = [[-1] * n for _ in range(m)]
        directions = [(0, 1), (1, 0), (0, -1), (-1, 0)]
        dir_idx = 0
        x, y = 0, 0
        current = head
        while current:
            result[x][y] = current.val
            next_x, next_y = x + directions[dir_idx][0], y + directions[dir_idx][1]
            if not (0 <= next_x < m and 0 <= next_y < n and result[next_x][next_y] == -1):
                dir_idx = (dir_idx + 1) % 4
                next_x, next_y = x + directions[dir_idx][0], y + directions[dir_idx][1]
            x, y = next_x, next_y
            current = current.next
        return result