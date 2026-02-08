class Solution:
    def furthestDistanceFromOrigin(self, moves: str) -> int:
        left = 0
        right = 0
        other = 0
        for move in moves:
            if move == 'L':
                left += 1
            elif move == 'R':
                right += 1
            else:
                other += 1
        return max(left, right) + other