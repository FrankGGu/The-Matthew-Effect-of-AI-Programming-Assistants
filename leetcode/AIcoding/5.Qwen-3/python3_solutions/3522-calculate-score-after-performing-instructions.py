class Solution:
    def calculateScore(self, operations: str) -> int:
        score = 0
        for op in operations:
            if op == 'A':
                score += 1
            elif op == 'B':
                score += 2
            elif op == 'C':
                score += 3
            elif op == 'D':
                score += 4
            elif op == 'E':
                score += 5
            elif op == 'F':
                score += 6
            elif op == 'G':
                score += 7
            elif op == 'H':
                score += 8
            elif op == 'I':
                score += 9
            elif op == 'J':
                score += 10
            elif op == 'K':
                score += 11
            elif op == 'L':
                score += 12
            elif op == 'M':
                score += 13
            elif op == 'N':
                score += 14
            elif op == 'O':
                score += 15
            elif op == 'P':
                score += 16
            elif op == 'Q':
                score += 17
            elif op == 'R':
                score += 18
            elif op == 'S':
                score += 19
            elif op == 'T':
                score += 20
            elif op == 'U':
                score += 21
            elif op == 'V':
                score += 22
            elif op == 'W':
                score += 23
            elif op == 'X':
                score += 24
            elif op == 'Y':
                score += 25
            elif op == 'Z':
                score += 26
        return score