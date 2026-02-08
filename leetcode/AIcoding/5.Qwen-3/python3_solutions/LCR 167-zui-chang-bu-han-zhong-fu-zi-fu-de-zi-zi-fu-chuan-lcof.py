class Solution:
    def dissectMove(self, moves: str) -> int:
        count = 0
        for c in moves:
            if c == 'A':
                count += 1
            elif c == 'B':
                count += 1
            elif c == 'C':
                count += 1
            elif c == 'D':
                count += 1
        return count